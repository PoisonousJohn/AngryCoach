
.pragma library

function notEmpty(textFieldsArray) {
    for (var i = 0; i < textFieldsArray.length; ++i) {
        var field = textFieldsArray[i];
        if (field.displayValue.length === 0) {
            return false;
        }
    }

    return true;
}
function numberGreaterThanZero(textFieldsArray) {
    var locale = Qt.locale();
    for (var i = 0; i < textFieldsArray.length; ++i) {
        var field = textFieldsArray[i];
        var number = Number.fromLocaleString(locale, field.displayValue);;
        if (!(number > 0)) {
            return false;
        }
    }

    return true;
}
