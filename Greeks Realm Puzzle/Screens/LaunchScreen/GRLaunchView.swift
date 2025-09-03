// GRLaunchView.swift
import SwiftUI
import UserNotifications
import UIKit

struct GRLaunchView: View {
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""

    @State private var showPrivacy = false
    @State private var showHome = false

    @State private var responded = false
    @State private var granted = false
    @State private var initialChecked = false
    @State private var initialWasNotDetermined = false
    @State private var awaitingSecondToken = false
    @State private var baselineDistinct = 0

    @State private var minSplashDone = false
    @State private var fired = false
    @State private var minTimer: DispatchWorkItem?
    @State private var pollTimer: Timer?

    private let minSplash: TimeInterval = 2
    private let postReadyDelay: TimeInterval = 1.2

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PrivacyView(), isActive: $showPrivacy) { EmptyView() }
                NavigationLink(destination: GRHomeView(),    isActive: $showHome)    { EmptyView() }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    Color(.white)
                    Image(.launchBackground)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            )
        }
        .hideNavigationBar()
        .onAppear {
            startMinSplash()
            startAuthPolling()
        }
        .onReceive(NotificationCenter.default.publisher(for: .fcmTokenDidUpdate)) { _ in
            tryProceed()
        }
        .onDisappear {
            minTimer?.cancel()
            pollTimer?.invalidate()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func startMinSplash() {
        minTimer?.cancel()
        let w = DispatchWorkItem {
            minSplashDone = true
            tryProceed()
        }
        minTimer = w
        DispatchQueue.main.asyncAfter(deadline: .now() + minSplash, execute: w)
    }

    private func startAuthPolling() {
        pollTimer?.invalidate()
        pollTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            checkNotifAuth()
        }
        RunLoop.main.add(pollTimer!, forMode: .common)
        checkNotifAuth()
    }

    private func checkNotifAuth() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let status = settings.authorizationStatus
            let isGranted = (status == .authorized || status == .provisional || status == .ephemeral)
            let hasResponded = (status != .notDetermined)
            DispatchQueue.main.async {
                if !initialChecked {
                    initialChecked = true
                    initialWasNotDetermined = (status == .notDetermined)
                }
                responded = hasResponded
                if isGranted && !granted {
                    granted = true
                    if initialWasNotDetermined {
                        awaitingSecondToken = true
                        baselineDistinct = UserDefaults.standard.integer(forKey: "fcmDistinctSinceLaunch")
                    } else {
                        awaitingSecondToken = false
                    }
                } else {
                    granted = isGranted
                    if !isGranted { awaitingSecondToken = false }
                }
                tryProceed()
            }
        }
    }

    private func tryProceed() {
        guard responded, minSplashDone, !fired else { return }

        let token = UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        let currentCnt = UserDefaults.standard.integer(forKey: "fcmDistinctSinceLaunch")

        var canProceed = false
        if granted {
            if awaitingSecondToken {
                canProceed = (!token.isEmpty && (currentCnt - baselineDistinct) >= 1)
            } else {
                canProceed = true
            }
        } else {
            canProceed = (!token.isEmpty && currentCnt >= 1)
        }
        guard canProceed else { return }

        fired = true
        pollTimer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + postReadyDelay) {
            if !stringURL.isEmpty {
                AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
                showPrivacy = true
            } else if firstOpenApp {
                AppDelegate.orientationLock =  [.portrait, .landscapeLeft, .landscapeRight]
                showPrivacy = true
            } else {
                AppDelegate.orientationLock = .portrait
                showHome = true
            }
        }
    }
}
