# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# configure the bundle identifier for iOS
PRODUCT_IDENTIFIER = com.vplay.ShoppingList
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

PRODUCT_LICENSE_KEY = "964E7518A1F68B55F3EE090AE3A459DBA38856F194FD79455F3B52532606302E456764AFB4F4DE44A9245FE2C727B018219A0D48B1DAD72EE08A944C25E0D4D04A0AA4399F5EAB667186549A742A09BD85823F49DFB4E3F35CE211CC4F0BC61AF249FE4DF819457D434839FABBF94F0568C98DA7FF04A4A1F1EAC024379E23150DD2480AB937EA9832D71027F4E52DE86D8B4BFB7950FE07EF4208FD9D55614800BF5094CE5FEA2FE96D0B55FFFAAB27151D13B7E45A871350230222F1FABAEF1925D625C71B48598EA62B80708DCBAB0B0B0F1E0D82778228F21F06BBD2EA1B82F57F722B7B78FA6F105392C1E02A057F4847F8B70AE90FD5A99AD864521D3FBF15B37CF89580C6AF464398E8B99549722CFF983CF1A4A41F6006484A1AAF1D381C75D140258263C61EFF7F5D193992"


qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
    
    FELGO_PLUGINS += firebase
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    qml/model/DataModel.qml
