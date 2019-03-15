function show_result(data) {
    $('#result').empty();
    let result = document.getElementById("result");
    for(let i=0; i < data.value.length; i = i+2){
        let new_row = result.insertRow(result.rows.length);
        let cell1 = new_row.insertCell(0);
        let text1 = document.createTextNode(data.value[i]);
        cell1.appendChild(text1);
        let cell2 = new_row.insertCell(1);
        let text2 = document.createTextNode(data.value[i+1]);
        cell2.appendChild(text2);
    }
}
$(document).on('click', document.getElementById('main_form'),function () {
    $("#main_form").on("ajax:success", function(event){
        show_result(event.detail[0]);
    })
});