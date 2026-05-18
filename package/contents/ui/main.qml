/*
 * Copyright (C) 2020 by Marcel Richter <Richter02@protonmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Library General Public License as
 * published by the Free Software Foundation; either version 2 or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2
import QtWebEngine 1.7

import org.kde.plasma.plasmoid
import "." as HtmlWallpaper

WallpaperItem {
    property int lastManualRefreshToken: wallpaper.configuration.ManualRefreshToken

    Timer {
        interval: Math.max(1, wallpaper.configuration.ForceRefreshInterval) * 1000
        repeat: true
        running: wallpaper.configuration.ForceRefreshInterval > 0
        triggeredOnStart: false
        onTriggered: webView.reloadAndBypassCache()
    }

    Connections {
        target: wallpaper.configuration

        function onManualRefreshTokenChanged() {
            if (wallpaper.configuration.ManualRefreshToken === lastManualRefreshToken) {
                return
            }

            lastManualRefreshToken = wallpaper.configuration.ManualRefreshToken
            webView.reloadAndBypassCache()
        }
    }

    WebEngineView{
        id: webView
        anchors.fill: parent
        profile: HtmlWallpaper.SharedProfile.profile
        url: wallpaper.configuration.DisplayPage
        zoomFactor: wallpaper.configuration.ZoomFactor
        backgroundColor: "black"
        onCertificateError: function (error) {
            if (wallpaper.configuration.InsecureHTTPS) {
                error.acceptCertificate()
            } else {
                error.rejectCertificate()
            }
        }
        settings.playbackRequiresUserGesture: false
    }
}
