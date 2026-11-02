// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include <KAboutData>
#include <KIconTheme>
#include <KLocalizedQmlContext>
#include <KLocalizedString>
#include <QApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QUrl>
#include <QtQml>
#include <kaboutdata.h>
#include <qhashfunctions.h>

int main(int argc, char *argv[]) {
  KIconTheme::initTheme();
  QApplication app(argc, argv);
  KLocalizedString::setApplicationDomain("Pagume");
  QApplication::setOrganizationName(QStringLiteral("Wesenseged"));
  QApplication::setOrganizationDomain(QStringLiteral("wesen.vercel.app"));
  QApplication::setApplicationName(QStringLiteral("Pagume"));
  QApplication::setDesktopFileName(
      QStringLiteral("io.github.wesenseged.Pagume"));

  app.setWindowIcon(
      QIcon::fromTheme(QStringLiteral("io.github.wesenseged.Pagume")));

  QApplication::setStyle(QStringLiteral("breeze"));
  if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE")) {
    QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
  }

  KAboutData aboutData(
      QStringLiteral("Pagume"), i18n("Pagume"), QStringLiteral("0.3.8"),
      i18n("Ethiopian calendar with main holidays"), KAboutLicense::GPL_V3,
      i18n("© 2026 Abenezer Wesenseged"), QString{},
      QStringLiteral("https://github.com/wesenseged/Pagume"));

  aboutData.setProgramLogo(app.windowIcon());
  aboutData.setUrl(KAboutData::Donation, QString{});
  aboutData.addAuthor(i18n("Abenezer Wesenseged"), i18n("Development"),
                      QStringLiteral("wseged@proton.me"));
  aboutData.setBugAddress(
      QByteArrayLiteral("https://github.com/wesenseged/Pagume/issues"));
  KAboutData::setApplicationData(aboutData);

  qmlRegisterSingletonType("org.wesen.about", 1, 0, "KAbout",
                           [](QQmlEngine *engine, QJSEngine *) -> QJSValue {
                             return engine->toScriptValue(
                                 KAboutData::applicationData());
                           });

  QQmlApplicationEngine engine;
  KLocalization::setupLocalizedContext(&engine);

  engine.loadFromModule("io.github.wesenseged.Pagume", "Main");

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}
