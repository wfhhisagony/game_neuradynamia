#ifndef MYEXCEPTION_H
#define MYEXCEPTION_H

#include <QException>

class MyException : public QException
{
public:
    explicit MyException(const QString& message);
    const char* what() const noexcept override;
private:
    QString m_message = "";
};

#endif // MYEXCEPTION_H
