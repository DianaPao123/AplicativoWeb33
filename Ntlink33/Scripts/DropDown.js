//$(document).ready(function () {
//    $(".DropDownListRGV").select2({
//        placeholder: "Seleccione",
//        allowClear: true
//    });


//    $('.drpCountryRGV').selectpicker({
//        style: 'btn-info',
//        size: 4
//    });   

//});


//function pageLoad() {
//    $(".DropDownListRGV").select2({
//        placeholder: "Seleccione",
//        allowClear: true
//    });

     
//}
//$(function () {
//    ApplySelectPicker();
//});
////On UpdatePanel Refresh
//var prm = Sys.WebForms.PageRequestManager.getInstance();
//if (prm != null) {
//    prm.add_endRequest(function (sender, e) {
//        if (sender._postBackSettings.panelsToUpdate != null) {
//            ApplySelectPicker();
//        }
//    });
//};
//function ApplySelectPicker() {
//    $('.drpCountryRGV').selectpicker({
//        //style: 'btn-light',
//        size: 5
        
//    });
//};

$(document).ready(function () {
    $('.drpCountryRGV').selectpicker({
        style: 'btn-info',
        size: 8
    });   

});

function pageLoad() {
    $('.drpCountryRGV').selectpicker({
        style: 'btn-info',
        size: 8
    });

};
