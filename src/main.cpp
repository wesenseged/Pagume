// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include <KAboutData>
#include <KIconTheme>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <QApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QUrl>
#include <QtQml>

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
      QStringLiteral("io.github.wesenseged.Pagume"), // not "org.kde."
      i18n("Pagume"), QStringLiteral("1.0"),
      i18n("A modern Ethiopian calendar app featuring major holidays and "
           "fasting periods."),
      KAboutLicense::GPL_V3, i18n("© 2026 Wesenseged Community"));

  KAboutData::setApplicationData(aboutData);

  qmlRegisterSingletonType("org.wesen.about", 1, 0, "About",
                           [](QQmlEngine *engine, QJSEngine *) -> QJSValue {
                             return engine->toScriptValue(
                                 KAboutData::applicationData());
                           });

  QQmlApplicationEngine engine;

  engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
  engine.loadFromModule("io.github.wesenseged.Pagume", "Main");

  if (engine.rootObjects().isEmpty()) {
    return -1;
  }

  return app.exec();
}
