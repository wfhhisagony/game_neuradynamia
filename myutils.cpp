#include "myutils.h"
#include <QDir>
#include <QException>
#include <QMessageBox>
//#include "myexception.h"
#include <QDebug>

MyUtils::MyUtils(QObject *parent)
    : QObject{parent}
{

}

QString MyUtils::getImgFullNameByPrefix(QString imgNameWithoutSuffix){
    for(int i=0;i<m_picNameList.size(); i++){
        QFileInfo fileInfo = m_picNameList.at(i);
        qDebug() << fileInfo.baseName();
        if(fileInfo.baseName().compare(imgNameWithoutSuffix)==0){
            qDebug() << fileInfo.filePath();
            return fileInfo.filePath();
        }
    }
    // if image Not found then throw exception
    //    QMessageBox::critical(nullptr, "Image Not Found", "RegExp:"+imgNameWithoutSuffix + "(png|jpeg|jpg|gif)/i");
    //    throw MyException("image index: " + imgNameWithoutSuffix + " Not Found");
    return NULL;
}

QString MyUtils::getImgFullNameByIndex(int index)
{
    if(index >= m_picNameList.size() || index < 0){
        // if image Not found then throw exception
        //    QMessageBox::critical(nullptr, "Image Not Found", "RegExp:"+imgNameWithoutSuffix + "(png|jpeg|jpg|gif)/i");
        //    throw MyException("image index: " + index + " Not Found");
        return NULL;
    }
    return m_picNameList.at(index).filePath();
}

void MyUtils::setPicNameList(QString i_dirName){
    setDirName(i_dirName);
    QStringList imgFileter;
    imgFileter << "*.png" << "*.jpeg" << "*.jpg" << "*.gif";
    QDir dir(i_dirName);
    dir.setNameFilters(imgFileter);
    m_picNameList.clear();
    m_picNameList = dir.entryInfoList();
    qDebug() << "detected img num:" << m_picNameList.size();
    qDebug() << m_picNameList;
}

QString MyUtils::dirName(){
    return m_dirName;
}
void MyUtils::setDirName(QString i_dirName){
    m_dirName = i_dirName;
}

MyUtils::~MyUtils()
{

}
