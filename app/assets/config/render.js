function transform(){
    str = "";
    for(i = 1; i <= 81; i++){
        str += document.getElementById(i).value;
        if(i%9 == 0){
            str += "|";
        }else{
            str += ",";
        }
    }
    str = str.slice(0, -1);
    document.getElementById('deck').value = str;
}