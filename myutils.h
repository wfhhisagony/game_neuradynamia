#ifndef MYUTILS_H
#define MYUTILS_H

#include <QObject>
#include <QFileInfoList>

class MyUtils : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString dirName READ dirName WRITE setDirName)
public:
    explicit MyUtils(QObject *parent = nullptr);
    ~MyUtils();

    QString dirName();
    void setDirName(QString i_dirName);

    Q_INVOKABLE QString getImgFullNameByPrefix(QString imgNameWithoutSuffix);
    Q_INVOKABLE QString getImgFullNameByIndex(int index);
    Q_INVOKABLE void setPicNameList(QString dirName);



private:
    QFileInfoList m_picNameList;
    QString m_dirName = NULL;

signals:

};

#endif // MYUTILS_H
