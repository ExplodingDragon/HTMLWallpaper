pragma Singleton

import QtQuick 2
import QtWebEngine 1.7

QtObject {
    readonly property WebEngineProfile profile: WebEngineProfile {
        offTheRecord: false
        storageName: "htmlwallpaper"
        httpCacheType: WebEngineProfile.DiskHttpCache
        persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
        persistentPermissionsPolicy: WebEngineProfile.StoreOnDisk
    }
}
