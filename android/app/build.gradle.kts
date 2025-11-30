plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")

    // Google Services plugin for Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.labtwo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.labtwo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

dependencies {
    // Firebase BOM (manages all versions)
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // Firebase Messaging (Push notifications)
    implementation("com.google.firebase:firebase-messaging")

    // OPTIONAL:
    // Firebase analytics if needed:
    // implementation("com.google.firebase:firebase-analytics")
}
