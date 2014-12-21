#ifndef SINGLETON_PLUGIN_H
#define SINGLETON_PLUGIN_H

#include <QQmlExtensionPlugin>

class SingletonPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // SINGLETON_PLUGIN_H

