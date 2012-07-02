//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, May 9, 2012  10:09:12 AM
// Author: henrichen

/**
 * A Cordova Contacts implementation.
 */
class CordovaContacts implements Contacts {
  static final String _FIND = "conts.1";  
  CordovaContacts() {
    _initJSFunctions();
  }
  void find(List<String> fields, ContactsSuccessCallback success, ContactsErrorCallback error, ContactsFindOptions contactOptions) {
    JSUtil.jsCall(_FIND, [JSUtil.toJSArray(fields), _wrapContactsFunction(success), _wrapErrorFunction(error), JSUtil.toJSMap(_toMap(contactOptions))]);
  }
  
  Map _toMap(ContactsFindOptions opts) {
    return {
      /** The search string used to filter Contacts; default "" */
      "filter" : opts.filter,
      /** Whether return multiple Contacts; default false */
      "multiple" : opts.multiple
    };
  }
    
  //parameter called back from javascript Cordova would be a json object {}, must convert paremeter type back to dart Contact
  _wrapContactsFunction(dartFn) {   
    return (jsContacts) => dartFn(JSUtil.toDartList(jsContacts, (jsContact) => new CordovaContact.from(JSUtil.toDartMap(jsContact))));
  }
    
  _wrapErrorFunction(dartFn) {
    return (jsErr) => dartFn(new ContactError.from(JSUtil.toDartMap(jsErr)));
  }
  
  void _initJSFunctions() {
    JSUtil.newJSFunction(_FIND, ["fields", "onSuccess", "onError", "opts"], '''
      var fnSuccess = function(contacts) {onSuccess.\$call\$1(contacts);},
          fnError = function(err) {onError.\$call\$1(err);};
      navigator.contacts.find(fields, fnSuccess, fnError, opts);
    ''');
  }
}

