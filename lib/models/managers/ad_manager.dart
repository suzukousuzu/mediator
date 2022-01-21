import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  int maxFailedToAttempt = 3;
  int _numInterstitialLoadAttempt = 0;


  Future<void> initAdmob() {
    return MobileAds.instance.initialize();
  }

  void initBannerAd() {
    bannerAd = BannerAd(
        adUnitId: bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener());
  }

  void initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
            _numInterstitialLoadAttempt = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            interstitialAd = null;
            _numInterstitialLoadAttempt++;
            if(_numInterstitialLoadAttempt <= maxFailedToAttempt) {
              initInterstitialAd();
            }
          }),);
  }

  void loadBannerAd() {
    bannerAd!.load();
  }

  void loadInterstitialAd() {
    _showInterstitialAd();
  }

  void _showInterstitialAd() {
    //TODO
    if(interstitialAd == null) return;
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        initInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        initInterstitialAd();
      }

    );
    interstitialAd!.show();
    interstitialAd = null;

  }


  dispose() {
    bannerAd!.dispose();
    interstitialAd!.dispose();
  }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4115624827228688~7575929730";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4115624827228688~2247581439";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4115624827228688/8505868028";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4115624827228688/1940459670";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }




}
