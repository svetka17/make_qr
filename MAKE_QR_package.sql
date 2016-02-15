CREATE OR REPLACE package ASUPPP.make_qr as
        
    --макс из 2х чисел
    function max_2(p1 in number default 0,p2 in number default null) RETURN NUMBER;
    
    --перевод hex в двоичный код
    function hex2bin (p_hex IN CLOB) return CLOB;
    
    --xor
    function bin_xor_bin (b1 IN varchar2, b2 in varchar2) return varchar2;

    --bin2dec
    function bin2dec (b1 IN varchar2) return number;

    --dec2hex
    function dec2hex (b1 IN number) return varchar2;
    
    --возвращает значение поля галуа
    function galua (n1 IN number) return number;
   
 --возвращает значение обратного поля галуа
    function galua_inv (n1 IN number) return number;
    
    --делает массив для рисования qr   
    function qr_bin(p_text in varchar2) return blob;-- clob;

end make_qr;
/
