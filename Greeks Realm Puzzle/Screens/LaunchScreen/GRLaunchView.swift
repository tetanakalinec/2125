// GRLaunchView.swift
import SwiftUI
import UserNotifications
import UIKit

struct GRLaunchView: View {
    @AppStorage("firstOpenApp") var firstOpenApp = true
    @AppStorage("stringURL") var stringURL = ""

    @State private var showPrivacy = false
    @State private var showHome = false

    @State private var responded = false       // ← оставляем
    @State private var minSplashDone = false
    @State private var fired = false
    @State private var minTimer: DispatchWorkItem?
    @State private var pollTimer: Timer?

    private let minSplash: TimeInterval       = 2.0      // минимум показать сплэш
    private let postConsentDelay: TimeInterval = 2.0      // ждать после ответа на алерт

    // простая константа окружения
    #if targetEnvironment(simulator)
    private let isSimulator = true
    #else
    private let isSimulator = false
    #endif

    var body: some View {
        NavigationView {
            VStack {
                Image(.olimTitle).resizable().scaledToFit().frame(height: 150)
                Image(.loader).resizable().scaledToFit().frame(height: 100).offset(y: 100)
                Spacer()

                NavigationLink(destination: PrivacyView(), isActive: $showPrivacy) { EmptyView() }
                NavigationLink(destination: GRHomeView(),    isActive: $showHome)    { EmptyView() }
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    Color(.white)
                    Image(.emptyBackground).resizable().scaledToFill().ignoresSafeArea()
                }
            )
        }
        .hideNavigationBar()
        .onAppear {
            startMinSplash()
            startAuthPolling()
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
        pollTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                let hasResponded = (settings.authorizationStatus != .notDetermined)
                DispatchQueue.main.async {
                    if self.responded != hasResponded {
                        self.responded = hasResponded
                        self.tryProceed()
                    } else {
                        self.tryProceed()
                    }
                }
            }
        }
        RunLoop.main.add(pollTimer!, forMode: .common)
    }

    private func tryProceed() {
        guard !fired else { return }

        if isSimulator {
            guard minSplashDone else { return }
            goNext(after: 0)
            return
        }

        if responded && minSplashDone {
            goNext(after: postConsentDelay)
        }
    }

    private func goNext(after delay: TimeInterval) {
        fired = true
        pollTimer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if !stringURL.isEmpty {
                AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
                showPrivacy = true
            } else if firstOpenApp {
                AppDelegate.orientationLock = [.portrait, .landscapeLeft, .landscapeRight]
                showPrivacy = true
            } else {
                AppDelegate.orientationLock = .portrait
                showHome = true
            }
        }
    }
}
