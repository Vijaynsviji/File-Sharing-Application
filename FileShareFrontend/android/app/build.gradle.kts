import com.android.build.api.dsl.ApplicationExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties

plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

val localProps = Properties().apply {
    val f = rootProject.file("local.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}

val sdkDir = (localProps.getProperty("sdk.dir")
    ?: System.getenv("ANDROID_HOME")
    ?: System.getenv("ANDROID_SDK_ROOT")
    ?: error("Android SDK not found")).replace("\\", "/")

val customNdkVersion = "28.2.13676358"
val customNdkPath = "$sdkDir/ndk/$customNdkVersion"

configure<ApplicationExtension> {
    namespace = "com.vijayns.file_share_application_frontend"
    compileSdk = flutter.compileSdkVersion

    ndkVersion = customNdkVersion

    // RESTORED: Forces Java to compile at version 17
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.vijayns.file_share_application_frontend"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        ndk {
            abiFilters += listOf("arm64-v8a", "x86_64")
        }

        externalNativeBuild {
            cmake {
                arguments += listOf(
                    "-DCMAKE_TOOLCHAIN_FILE=C:/Users/VijayNSadashiva/.vcpkg-clion/vcpkg/scripts/buildsystems/vcpkg.cmake",
                    "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=$customNdkPath/build/cmake/android.toolchain.cmake",
                    "-DANDROID_PLATFORM=android-24"
                )
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
        }
    }
}

// RESTORED: Forces Kotlin to compile at version 17
kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
    }
}

flutter {
    source = "../.."
}