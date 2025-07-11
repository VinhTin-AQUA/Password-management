plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.newtun.password_management"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13599879"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.newtun.password_management"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")   
        }

        getByName("release") {
            // Dùng key debug tạm thời để ký bản release
            signingConfig = signingConfigs.getByName("debug")

            // Bật R8/proguard để rút gọn code
            isMinifyEnabled = true

            // Không bật rút gọn tài nguyên (có thể bật nếu bạn cần giảm kích thước APK)
            isShrinkResources = false

            // Sử dụng proguard file mặc định + file custom nếu có
            // proguardFiles(
                // getDefaultProguardFile("proguard-android-optimize.txt"),
                // "proguard-rules.pro"
            // )
        }
    }
}

flutter {
    source = "../.."
}
