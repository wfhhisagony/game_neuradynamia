#include "myexception.h"

MyException::MyException(const QString& message)
{
    m_message = message;
}

const char* MyException::what() const noexcept {
    return m_message.toStdString().c_str();
}
