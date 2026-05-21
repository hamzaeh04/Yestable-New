plugins {
  id("com.android.application")
  id("com.google.gms.google-services")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.example.yestable"

  // Updated for image_cropper
  compileSdk = 36

  ndkVersion = "29.0.13113456"

  compileOptions {

    // Required for flutter_local_notifications
    isCoreLibraryDesugaringEnabled = true

    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }

  kotlinOptions {
    jvmTarget = "11"
  }

  defaultConfig {
    applicationId = "com.example.yestable"

    minSdk = 25
    targetSdk = 36

    versionCode = flutter.versionCode
    versionName = flutter.versionName
  }

  buildTypes {
    release {
      signingConfig = signingConfigs.getByName("debug")
    }
  }
}

flutter {
  source = "../.."
}

dependencies {

  implementation("androidx.appcompat:appcompat:1.4.0")

  // Required for desugaring
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
