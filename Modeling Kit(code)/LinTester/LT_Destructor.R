#Destructor functions

destroyLinTester <- function(){
removeClass(Class='LinTester')
removeMethod(initialize,signature='LinTester')
removeMethod(print,signature='LinTester')
removeMethod(show,signature='LinTester')
removeMethod(rebin,signature='LinTester')
removeMethod(validate,signature='LinTester')
removeMethod(getData,signature='LinTester')
removeMethod(getForm,signature='LinTester')
removeMethod(getErrors,signature='LinTester')
removeMethod(getResponse,signature='LinTester')
removeMethod(setData,signature='LinTester')
removeMethod(setResponse,signature='LinTester')
removeMethod(setForm,signature='LinTester')
removeMethod(setAll,signature='LinTester')

}