CREATE OR REPLACE PACKAGE BODY ASUPPP.make_qr
AS
FUNCTION hex2bin (p_hex IN CLOB)
   RETURN CLOB
as
   p_bin          CLOB  :=NULL;
   p_semibyte     VARCHAR2 (4);
BEGIN
   FOR i IN 1 .. DBMS_LOB.GETLENGTH (p_hex)
   LOOP
      WITH t1 AS (SELECT TO_NUMBER (DBMS_LOB.SUBSTR(p_hex, 1, i), 'X') num FROM DUAL)
          SELECT TO_CHAR (reverse (MAX (REPLACE (SYS_CONNECT_BY_PATH (SIGN (BITAND (t1.num, POWER (2, LEVEL - 1))), ','), ','))), 'FM0000') bin
            INTO p_semibyte
            FROM t1
      CONNECT BY POWER (2, LEVEL - 1) <= t1.num;
      p_bin := p_bin || p_semibyte;
   END LOOP;

   RETURN p_bin;
END;

function bin2dec (b1 IN varchar2) return number
as
l1 number:=0;
l2 number:=0;
t1 varchar2(1):='';
t2 varchar2(1):='';
t10 varchar2(100):='';
t20 varchar2(100):='';
r number:=0;
begin
l1:=length(b1); l2:=0; r:=0;
if l1>1 then 
t10:=b1; --t20:=b2;
--if l1>l2 then t20:=lpad(b2,l1,'0'); else t10:=lpad(b1,l2,'0');  end if;
    for i in reverse 1 .. l1 loop
    t1:=substr(t10,i,1);
    r:=r+power(2,l2)*to_number(t1);
    l2:=l2+1;
    end loop;
end if;
return r;
end;

function dec2hex (b1 IN number) return varchar2
as
begin
return trim(to_char(b1,'XXXX'));
end;

function bin_xor_bin (b1 IN varchar2, b2 in varchar2) return varchar2
as
l1 number:=0;
l2 number:=0;
t1 varchar2(1):='';
t2 varchar2(1):='';
t10 varchar2(100):='';
t20 varchar2(100):='';
r varchar2(100):='';
begin
l1:=length(b1); l2:=length(b2);
t10:=b1; t20:=b2;
if l1>l2 then t20:=lpad(b2,l1,'0'); else t10:=lpad(b1,l2,'0');  end if;
    for i in reverse 1 .. max_2(l1,l2) loop
    t1:=substr(t10,i,1);
    t2:=substr(t20,i,1);
    if t1=t2 then r:='0'||r; else r:='1'||r; end if;
    end loop;
return lpad(r,8,'0');
end;
FUNCTION max_2(p1 in number default 0,p2 in number default null) RETURN NUMBER as
BEGIN
   if (p1>=p2) or (p2 is null) then
     return p1;
   else
     return p2;
   end if;        
END;

function galua (n1 IN number) return number
as
nn number:=null;
begin
for s in (select u, val from (
select 0 u, 1 val from dual union all    select 1 u, 2 val from dual union all    select 2 u, 4 val from dual union all    select 3 u, 8 val from dual union all    select 4 u, 16 val from dual union all    select 5 u, 32 val from dual union all    select 6 u, 64 val from dual union all    select 7 u, 128 val from dual union all    select 8 u, 29 val from dual union all    select 9 u, 58 val from dual union all    select 10 u, 116 val from dual union all    select 11 u, 232 val from dual union all    select 12 u, 205 val from dual union all    select 13 u, 135 val from dual union all    select 14 u, 19 val from dual union all    select 15 u, 38 val from dual union all                                        
select 16 u, 76 val from dual union all    select 17 u, 152 val from dual union all    select 18 u, 45 val from dual union all    select 19 u, 90 val from dual union all    select 20 u, 180 val from dual union all    select 21 u, 117 val from dual union all    select 22 u, 234 val from dual union all    select 23 u, 201 val from dual union all    select 24 u, 143 val from dual union all    select 25 u, 3 val from dual union all    select 26 u, 6 val from dual union all    select 27 u, 12 val from dual union all    select 28 u, 24 val from dual union all    select 29 u, 48 val from dual union all    select 30 u, 96 val from dual union all    select 31 u, 192 val from dual union all                                                            
select 32 u, 157 val from dual union all    select 33 u, 39 val from dual union all    select 34 u, 78 val from dual union all    select 35 u, 156 val from dual union all    select 36 u, 37 val from dual union all    select 37 u, 74 val from dual union all    select 38 u, 148 val from dual union all    select 39 u, 53 val from dual union all    select 40 u, 106 val from dual union all    select 41 u, 212 val from dual union all    select 42 u, 181 val from dual union all    select 43 u, 119 val from dual union all    select 44 u, 238 val from dual union all    select 45 u, 193 val from dual union all    select 46 u, 159 val from dual union all    select 47 u, 35 val from dual union all
select 48 u, 70 val from dual union all    select 49 u, 140 val from dual union all    select 50 u, 5 val from dual union all    select 51 u, 10 val from dual union all    select 52 u, 20 val from dual union all    select 53 u, 40 val from dual union all    select 54 u, 80 val from dual union all    select 55 u, 160 val from dual union all    select 56 u, 93 val from dual union all    select 57 u, 186 val from dual union all    select 58 u, 105 val from dual union all    select 59 u, 210 val from dual union all    select 60 u, 185 val from dual union all    select 61 u, 111 val from dual union all    select 62 u, 222 val from dual union all    select 63 u, 161 val from dual union all                                                            
select 64 u, 95 val from dual union all    select 65 u, 190 val from dual union all    select 66 u, 97 val from dual union all    select 67 u, 194 val from dual union all    select 68 u, 153 val from dual union all    select 69 u, 47 val from dual union all    select 70 u, 94 val from dual union all    select 71 u, 188 val from dual union all    select 72 u, 101 val from dual union all    select 73 u, 202 val from dual union all    select 74 u, 137 val from dual union all    select 75 u, 15 val from dual union all    select 76 u, 30 val from dual union all    select 77 u, 60 val from dual union all    select 78 u, 120 val from dual union all    select 79 u, 240 val from dual union all                                                            
select 80 u, 253 val from dual union all    select 81 u, 231 val from dual union all    select 82 u, 211 val from dual union all    select 83 u, 187 val from dual union all    select 84 u, 107 val from dual union all    select 85 u, 214 val from dual union all    select 86 u, 177 val from dual union all    select 87 u, 127 val from dual union all    select 88 u, 254 val from dual union all    select 89 u, 225 val from dual union all    select 90 u, 223 val from dual union all    select 91 u, 163 val from dual union all    select 92 u, 91 val from dual union all    select 93 u, 182 val from dual union all    select 94 u, 113 val from dual union all    select 95 u, 226 val from dual union all                                                            
select 96 u, 217 val from dual union all    select 97 u, 175 val from dual union all    select 98 u, 67 val from dual union all    select 99 u, 134 val from dual union all    select 100 u, 17 val from dual union all    select 101 u, 34 val from dual union all    select 102 u, 68 val from dual union all    select 103 u, 136 val from dual union all    select 104 u, 13 val from dual union all    select 105 u, 26 val from dual union all    select 106 u, 52 val from dual union all    select 107 u, 104 val from dual union all    select 108 u, 208 val from dual union all    select 109 u, 189 val from dual union all    select 110 u, 103 val from dual union all    select 111 u, 206 val from dual union all                                                            
select 112 u, 129 val from dual union all    select 113 u, 31 val from dual union all    select 114 u, 62 val from dual union all    select 115 u, 124 val from dual union all    select 116 u, 248 val from dual union all    select 117 u, 237 val from dual union all    select 118 u, 199 val from dual union all    select 119 u, 147 val from dual union all    select 120 u, 59 val from dual union all    select 121 u, 118 val from dual union all    select 122 u, 236 val from dual union all    select 123 u, 197 val from dual union all    select 124 u, 151 val from dual union all    select 125 u, 51 val from dual union all    select 126 u, 102 val from dual union all    select 127 u, 204 val from dual union all                                                            
select 128 u, 133 val from dual union all    select 129 u, 23 val from dual union all    select 130 u, 46 val from dual union all    select 131 u, 92 val from dual union all    select 132 u, 184 val from dual union all    select 133 u, 109 val from dual union all    select 134 u, 218 val from dual union all    select 135 u, 169 val from dual union all    select 136 u, 79 val from dual union all    select 137 u, 158 val from dual union all    select 138 u, 33 val from dual union all    select 139 u, 66 val from dual union all    select 140 u, 132 val from dual union all    select 141 u, 21 val from dual union all    select 142 u, 42 val from dual union all    select 143 u, 84 val from dual union all                                                            
select 144 u, 168 val from dual union all    select 145 u, 77 val from dual union all    select 146 u, 154 val from dual union all    select 147 u, 41 val from dual union all    select 148 u, 82 val from dual union all    select 149 u, 164 val from dual union all    select 150 u, 85 val from dual union all    select 151 u, 170 val from dual union all    select 152 u, 73 val from dual union all    select 153 u, 146 val from dual union all    select 154 u, 57 val from dual union all    select 155 u, 114 val from dual union all    select 156 u, 228 val from dual union all    select 157 u, 213 val from dual union all    select 158 u, 183 val from dual union all    select 159 u, 115 val from dual union all                                                            
select 160 u, 230 val from dual union all    select 161 u, 209 val from dual union all    select 162 u, 191 val from dual union all    select 163 u, 99 val from dual union all    select 164 u, 198 val from dual union all    select 165 u, 145 val from dual union all    select 166 u, 63 val from dual union all    select 167 u, 126 val from dual union all    select 168 u, 252 val from dual union all    select 169 u, 229 val from dual union all    select 170 u, 215 val from dual union all    select 171 u, 179 val from dual union all    select 172 u, 123 val from dual union all    select 173 u, 246 val from dual union all    select 174 u, 241 val from dual union all    select 175 u, 255 val from dual union all                                                            
select 176 u, 227 val from dual union all    select 177 u, 219 val from dual union all    select 178 u, 171 val from dual union all    select 179 u, 75 val from dual union all    select 180 u, 150 val from dual union all    select 181 u, 49 val from dual union all    select 182 u, 98 val from dual union all    select 183 u, 196 val from dual union all    select 184 u, 149 val from dual union all    select 185 u, 55 val from dual union all    select 186 u, 110 val from dual union all    select 187 u, 220 val from dual union all    select 188 u, 165 val from dual union all    select 189 u, 87 val from dual union all    select 190 u, 174 val from dual union all    select 191 u, 65 val from dual union all                                                            
select 192 u, 130 val from dual union all    select 193 u, 25 val from dual union all    select 194 u, 50 val from dual union all    select 195 u, 100 val from dual union all    select 196 u, 200 val from dual union all    select 197 u, 141 val from dual union all    select 198 u, 7 val from dual union all    select 199 u, 14 val from dual union all    select 200 u, 28 val from dual union all    select 201 u, 56 val from dual union all    select 202 u, 112 val from dual union all    select 203 u, 224 val from dual union all    select 204 u, 221 val from dual union all    select 205 u, 167 val from dual union all    select 206 u, 83 val from dual union all    select 207 u, 166 val from dual union all                                                            
select 208 u, 81 val from dual union all    select 209 u, 162 val from dual union all    select 210 u, 89 val from dual union all    select 211 u, 178 val from dual union all    select 212 u, 121 val from dual union all    select 213 u, 242 val from dual union all    select 214 u, 249 val from dual union all    select 215 u, 239 val from dual union all    select 216 u, 195 val from dual union all    select 217 u, 155 val from dual union all    select 218 u, 43 val from dual union all    select 219 u, 86 val from dual union all    select 220 u, 172 val from dual union all    select 221 u, 69 val from dual union all    select 222 u, 138 val from dual union all    select 223 u, 9 val from dual union all                                                            
select 224 u, 18 val from dual union all    select 225 u, 36 val from dual union all    select 226 u, 72 val from dual union all    select 227 u, 144 val from dual union all    select 228 u, 61 val from dual union all    select 229 u, 122 val from dual union all    select 230 u, 244 val from dual union all    select 231 u, 245 val from dual union all    select 232 u, 247 val from dual union all    select 233 u, 243 val from dual union all    select 234 u, 251 val from dual union all    select 235 u, 235 val from dual union all    select 236 u, 203 val from dual union all    select 237 u, 139 val from dual union all    select 238 u, 11 val from dual union all    select 239 u, 22 val from dual union all                                                            
select 240 u, 44 val from dual union all    select 241 u, 88 val from dual union all    select 242 u, 176 val from dual union all    select 243 u, 125 val from dual union all    select 244 u, 250 val from dual union all    select 245 u, 233 val from dual union all    select 246 u, 207 val from dual union all    select 247 u, 131 val from dual union all    select 248 u, 27 val from dual union all    select 249 u, 54 val from dual union all    select 250 u, 108 val from dual union all    select 251 u, 216 val from dual union all    select 252 u, 173 val from dual union all    select 253 u, 71 val from dual union all    select 254 u, 142 val from dual union all    select 255 u, 1 val from dual )
where u=n1
)
loop
nn:=s.val;
end loop;
return nn;
end;

function galua_inv (n1 IN number) return number
as
nn number:=null;
begin
for s in (select u, val from (
select 0 u, null val from dual union all    select 1 u, 0 val from dual union all    select 2 u, 1 val from dual union all    select 3 u, 25 val from dual union all    select 4 u, 2 val from dual union all    select 5 u, 50 val from dual union all    select 6 u, 26 val from dual union all    select 7 u, 198 val from dual union all    select 8 u, 3 val from dual union all    select 9 u, 223 val from dual union all    select 10 u, 51 val from dual union all    select 11 u, 238 val from dual union all    select 12 u, 27 val from dual union all    select 13 u, 104 val from dual union all    select 14 u, 199 val from dual union all    select 15 u, 75 val from dual union all
select 16 u, 4 val from dual union all    select 17 u, 100 val from dual union all    select 18 u, 224 val from dual union all    select 19 u, 14 val from dual union all    select 20 u, 52 val from dual union all    select 21 u, 141 val from dual union all    select 22 u, 239 val from dual union all    select 23 u, 129 val from dual union all    select 24 u, 28 val from dual union all    select 25 u, 193 val from dual union all    select 26 u, 105 val from dual union all    select 27 u, 248 val from dual union all    select 28 u, 200 val from dual union all    select 29 u, 8 val from dual union all    select 30 u, 76 val from dual union all    select 31 u, 113 val from dual union all
select 32 u, 5 val from dual union all    select 33 u, 138 val from dual union all    select 34 u, 101 val from dual union all    select 35 u, 47 val from dual union all    select 36 u, 225 val from dual union all    select 37 u, 36 val from dual union all    select 38 u, 15 val from dual union all    select 39 u, 33 val from dual union all    select 40 u, 53 val from dual union all    select 41 u, 147 val from dual union all    select 42 u, 142 val from dual union all    select 43 u, 218 val from dual union all    select 44 u, 240 val from dual union all    select 45 u, 18 val from dual union all    select 46 u, 130 val from dual union all    select 47 u, 69 val from dual union all
select 48 u, 29 val from dual union all    select 49 u, 181 val from dual union all    select 50 u, 194 val from dual union all    select 51 u, 125 val from dual union all    select 52 u, 106 val from dual union all    select 53 u, 39 val from dual union all    select 54 u, 249 val from dual union all    select 55 u, 185 val from dual union all    select 56 u, 201 val from dual union all    select 57 u, 154 val from dual union all    select 58 u, 9 val from dual union all    select 59 u, 120 val from dual union all    select 60 u, 77 val from dual union all    select 61 u, 228 val from dual union all    select 62 u, 114 val from dual union all    select 63 u, 166 val from dual union all
select 64 u, 6 val from dual union all    select 65 u, 191 val from dual union all    select 66 u, 139 val from dual union all    select 67 u, 98 val from dual union all    select 68 u, 102 val from dual union all    select 69 u, 221 val from dual union all    select 70 u, 48 val from dual union all    select 71 u, 253 val from dual union all    select 72 u, 226 val from dual union all    select 73 u, 152 val from dual union all    select 74 u, 37 val from dual union all    select 75 u, 179 val from dual union all    select 76 u, 16 val from dual union all    select 77 u, 145 val from dual union all    select 78 u, 34 val from dual union all    select 79 u, 136 val from dual union all
select 80 u, 54 val from dual union all    select 81 u, 208 val from dual union all    select 82 u, 148 val from dual union all    select 83 u, 206 val from dual union all    select 84 u, 143 val from dual union all    select 85 u, 150 val from dual union all    select 86 u, 219 val from dual union all    select 87 u, 189 val from dual union all    select 88 u, 241 val from dual union all    select 89 u, 210 val from dual union all    select 90 u, 19 val from dual union all    select 91 u, 92 val from dual union all    select 92 u, 131 val from dual union all    select 93 u, 56 val from dual union all    select 94 u, 70 val from dual union all    select 95 u, 64 val from dual union all
select 96 u, 30 val from dual union all    select 97 u, 66 val from dual union all    select 98 u, 182 val from dual union all    select 99 u, 163 val from dual union all    select 100 u, 195 val from dual union all    select 101 u, 72 val from dual union all    select 102 u, 126 val from dual union all    select 103 u, 110 val from dual union all    select 104 u, 107 val from dual union all    select 105 u, 58 val from dual union all    select 106 u, 40 val from dual union all    select 107 u, 84 val from dual union all    select 108 u, 250 val from dual union all    select 109 u, 133 val from dual union all    select 110 u, 186 val from dual union all    select 111 u, 61 val from dual union all
select 112 u, 202 val from dual union all    select 113 u, 94 val from dual union all    select 114 u, 155 val from dual union all    select 115 u, 159 val from dual union all    select 116 u, 10 val from dual union all    select 117 u, 21 val from dual union all    select 118 u, 121 val from dual union all    select 119 u, 43 val from dual union all    select 120 u, 78 val from dual union all    select 121 u, 212 val from dual union all    select 122 u, 229 val from dual union all    select 123 u, 172 val from dual union all    select 124 u, 115 val from dual union all    select 125 u, 243 val from dual union all    select 126 u, 167 val from dual union all    select 127 u, 87 val from dual union all
select 128 u, 7 val from dual union all    select 129 u, 112 val from dual union all    select 130 u, 192 val from dual union all    select 131 u, 247 val from dual union all    select 132 u, 140 val from dual union all    select 133 u, 128 val from dual union all    select 134 u, 99 val from dual union all    select 135 u, 13 val from dual union all    select 136 u, 103 val from dual union all    select 137 u, 74 val from dual union all    select 138 u, 222 val from dual union all    select 139 u, 237 val from dual union all    select 140 u, 49 val from dual union all    select 141 u, 197 val from dual union all    select 142 u, 254 val from dual union all    select 143 u, 24 val from dual union all
select 144 u, 227 val from dual union all    select 145 u, 165 val from dual union all    select 146 u, 153 val from dual union all    select 147 u, 119 val from dual union all    select 148 u, 38 val from dual union all    select 149 u, 184 val from dual union all    select 150 u, 180 val from dual union all    select 151 u, 124 val from dual union all    select 152 u, 17 val from dual union all    select 153 u, 68 val from dual union all    select 154 u, 146 val from dual union all    select 155 u, 217 val from dual union all    select 156 u, 35 val from dual union all    select 157 u, 32 val from dual union all    select 158 u, 137 val from dual union all    select 159 u, 46 val from dual union all
select 160 u, 55 val from dual union all    select 161 u, 63 val from dual union all    select 162 u, 209 val from dual union all    select 163 u, 91 val from dual union all    select 164 u, 149 val from dual union all    select 165 u, 188 val from dual union all    select 166 u, 207 val from dual union all    select 167 u, 205 val from dual union all    select 168 u, 144 val from dual union all    select 169 u, 135 val from dual union all    select 170 u, 151 val from dual union all    select 171 u, 178 val from dual union all    select 172 u, 220 val from dual union all    select 173 u, 252 val from dual union all    select 174 u, 190 val from dual union all    select 175 u, 97 val from dual union all
select 176 u, 242 val from dual union all    select 177 u, 86 val from dual union all    select 178 u, 211 val from dual union all    select 179 u, 171 val from dual union all    select 180 u, 20 val from dual union all    select 181 u, 42 val from dual union all    select 182 u, 93 val from dual union all    select 183 u, 158 val from dual union all    select 184 u, 132 val from dual union all    select 185 u, 60 val from dual union all    select 186 u, 57 val from dual union all    select 187 u, 83 val from dual union all    select 188 u, 71 val from dual union all    select 189 u, 109 val from dual union all    select 190 u, 65 val from dual union all    select 191 u, 162 val from dual union all
select 192 u, 31 val from dual union all    select 193 u, 45 val from dual union all    select 194 u, 67 val from dual union all    select 195 u, 216 val from dual union all    select 196 u, 183 val from dual union all    select 197 u, 123 val from dual union all    select 198 u, 164 val from dual union all    select 199 u, 118 val from dual union all    select 200 u, 196 val from dual union all    select 201 u, 23 val from dual union all    select 202 u, 73 val from dual union all    select 203 u, 236 val from dual union all    select 204 u, 127 val from dual union all    select 205 u, 12 val from dual union all    select 206 u, 111 val from dual union all    select 207 u, 246 val from dual union all
select 208 u, 108 val from dual union all    select 209 u, 161 val from dual union all    select 210 u, 59 val from dual union all    select 211 u, 82 val from dual union all    select 212 u, 41 val from dual union all    select 213 u, 157 val from dual union all    select 214 u, 85 val from dual union all    select 215 u, 170 val from dual union all    select 216 u, 251 val from dual union all    select 217 u, 96 val from dual union all    select 218 u, 134 val from dual union all    select 219 u, 177 val from dual union all    select 220 u, 187 val from dual union all    select 221 u, 204 val from dual union all    select 222 u, 62 val from dual union all    select 223 u, 90 val from dual union all
select 224 u, 203 val from dual union all    select 225 u, 89 val from dual union all    select 226 u, 95 val from dual union all    select 227 u, 176 val from dual union all    select 228 u, 156 val from dual union all    select 229 u, 169 val from dual union all    select 230 u, 160 val from dual union all    select 231 u, 81 val from dual union all    select 232 u, 11 val from dual union all    select 233 u, 245 val from dual union all    select 234 u, 22 val from dual union all    select 235 u, 235 val from dual union all    select 236 u, 122 val from dual union all    select 237 u, 117 val from dual union all    select 238 u, 44 val from dual union all    select 239 u, 215 val from dual union all                                                          
select 240 u, 79 val from dual union all    select 241 u, 174 val from dual union all    select 242 u, 213 val from dual union all    select 243 u, 233 val from dual union all    select 244 u, 230 val from dual union all    select 245 u, 231 val from dual union all    select 246 u, 173 val from dual union all    select 247 u, 232 val from dual union all    select 248 u, 116 val from dual union all    select 249 u, 214 val from dual union all    select 250 u, 244 val from dual union all    select 251 u, 234 val from dual union all    select 252 u, 168 val from dual union all    select 253 u, 80 val from dual union all    select 254 u, 88 val from dual union all    select 255 u, 175 val from dual
 )
where u=n1
)
loop
nn:=s.val;
end loop;
return nn;
end;


 function qr_bin(p_text in varchar2) return blob
 as
 p_bin          CLOB  :=NULL;
 p_t  VARCHAR2 (32000);
 p_b clob := null;
 p_b_tmp clob := null;
 p_l number := 0;
 p_u number := 0;
 p_v number := 0;
 tmp number:=0;
 fff VARCHAR2(8);
 d number;
 dgi number;
 bmp_tmp blob;
 strhex varchar2(32000) := '424DE62F0000000000003E0000002800000031010000310100000100010000000000A82F00000000000000000000000000000000000000000000FFFFFF00';
 --b1 number:=0;b2 number:=0;b3 number:=0;b4 number:=0;b5 number:=0;b6 number:=0;b7 number:=0;b8 number:=0;b9 number:=0;b10 number:=0;
 --b11 number:=0;b12 number:=0;b13 number:=0;b14 number:=0;b15 number:=0;b16 number:=0;b17 number:=0;b18 number:=0;b19 number:=0;b20 number:=0;
 --b21 number:=0;b22 number:=0;b23 number:=0;b24 number:=0;b25 number:=0;b26 number:=0;b27 number:=0;b28 number:=0;b29 number:=0;b30 number:=0;
 ostatok_mod number :=0;
 count_byte number :=0; count_byte1 number :=0;
 korr_byte number :=0;
 p_type varchar2(1) := '';
 korr_mnogochlen varchar2(300) := '';
 korr_mnogochlen_bin varchar2(32000) := '';
 korr_mnogochlen_bin_tmp varchar2(32000) := '';
 korr_mnogochlen_tutto varchar2(32000) := '';
 tutto varchar2(32000) := '';
 p_tmp varchar2(8) := '11101100';
 korr_mn varchar2(32000) := '';
 draw varchar2(32000) := '';
 aaa varchar2(32000) := '';
 aaa_tmp varchar2(32000) := '';
 poisk_coor varchar2(300) := '';
 count_poisk number :=0;
 quadro number :=21;
 mincoor number :=0;
 maxcoor number :=0;
 m number :=0;
 n number :=0;
  kod_maski number :=0;
kod_versii varchar2(25) := '';
colonka number;
stroka number; tmp1 number; s_s varchar2(2):=''; tmp_draw varchar2(2):=''; flag number; flag_lr number;
 begin
 select length(p_text) into p_l from dual;
     if p_l=0 or p_l>2330 then
        dbms_lob.createtemporary(bmp_tmp, true);
        aaa:='';
        aaa_tmp:='424D6601000000000000760000002800000014000000140000000100040000000000F0000000000000000000000000000000000000000000000000008000008000000080800080000000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFBBBBFFFFFFFF0000FFFFFFBBBBBBBBFFFFFF0000FFFFBBBBBBBBBBBBFFFF0000FFFFBBBBB000BBBBFFFF0000FFFBBBBBBBB000BBBFFF0000FFBBBBBBBBBBB00BBFFF0000FFBBBBBBBBBBBBBBBBFF0000FFBBBBBBBBBBBBBBBBFF0000FFBBBBBBBBBBBBBBBBFF0000FFBBB000BBBB000BBBFF0000FFBB0B000BB0B000BFFF0000FFF0B0000BB0000B0FFF0000FFFFBBBBBBBBBBBBFFFF0000FFFFBBBBBBBBBBBBFFFF0000FFFFFFBBBBBBBBFFFFFF0000FFFFFFFBBBBBBFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000';
          FOR i IN 0..357 LOOP
          aaa := aaa ||chr(to_number(substr(aaa_tmp,i*2+1,2),'XX'));
          END LOOP;
        dbms_lob.append(bmp_tmp, utl_raw.cast_to_raw(trim(aaa)));
        return bmp_tmp;
        dbms_lob.freetemporary(bmp_tmp);
     end if;
 select length(hex2bin(rawtohex(convert(p_text,'utf8')) )) into p_l from dual;
 for s in (
 select u, val,typ from (
 select u, val,typ from ( 
  select 1 u, 152 val, 'l' typ from dual union all    select 2 u, 272 val, 'l' typ from dual union all    select 3 u, 440 val, 'l' typ from dual union all    select 4 u, 640 val, 'l' typ from dual union all    select 5 u, 864 val, 'l' typ from dual union all    select 6 u, 1088 val, 'l' typ from dual union all    select 7 u, 1248 val, 'l' typ from dual union all    select 8 u, 1552 val, 'l' typ from dual union all    select 9 u, 1856 val, 'l' typ from dual union all    select 10 u, 2192 val, 'l' typ from dual union all    select 11 u, 2592 val, 'l' typ from dual union all    select 12 u, 2960 val, 'l' typ from dual union all    select 13 u, 3424 val, 'l' typ from dual union all    select 14 u, 3688 val, 'l' typ from dual union all    select 15 u, 4184 val, 'l' typ from dual union all    select 16 u, 4712 val, 'l' typ from dual union all    select 17 u, 5176 val, 'l' typ from dual union all    select 18 u, 5768 val, 'l' typ from dual union all    select 19 u, 6360 val, 'l' typ from dual union all    select 20 u, 6888 val, 'l' typ from dual union all    select 21 u, 7456 val, 'l' typ from dual union all    select 22 u, 8048 val, 'l' typ from dual union all    select 23 u, 8752 val, 'l' typ from dual union all    select 24 u, 9392 val, 'l' typ from dual union all    select 25 u, 10208 val, 'l' typ from dual union all    select 26 u, 10960 val, 'l' typ from dual union all    select 27 u, 11744 val, 'l' typ from dual union all    select 28 u, 12248 val, 'l' typ from dual union all    select 29 u, 13048 val, 'l' typ from dual union all    select 30 u, 13880 val, 'l' typ from dual union all    select 31 u, 14744 val, 'l' typ from dual union all    select 32 u, 15640 val, 'l' typ from dual union all    select 33 u, 16568 val, 'l' typ from dual union all    select 34 u, 17528 val, 'l' typ from dual union all    select 35 u, 18448 val, 'l' typ from dual union all    select 36 u, 19472 val, 'l' typ from dual union all    select 37 u, 20528 val, 'l' typ from dual union all    select 38 u, 21616 val, 'l' typ from dual union all    select 39 u, 22496 val, 'l' typ from dual union all    select 40 u, 23648 val, 'l' typ from dual union all
  select 1 u, 128 val, 'm' typ from dual union all    select 2 u, 224 val, 'm' typ from dual union all    select 3 u, 352 val, 'm' typ from dual union all    select 4 u, 512 val, 'm' typ from dual union all    select 5 u, 688 val, 'm' typ from dual union all    select 6 u, 864 val, 'm' typ from dual union all    select 7 u, 992 val, 'm' typ from dual union all    select 8 u, 1232 val, 'm' typ from dual union all    select 9 u, 1456 val, 'm' typ from dual union all    select 10 u, 1728 val, 'm' typ from dual union all    select 11 u, 2032 val, 'm' typ from dual union all    select 12 u, 2320 val, 'm' typ from dual union all    select 13 u, 2672 val, 'm' typ from dual union all    select 14 u, 2920 val, 'm' typ from dual union all    select 15 u, 3320 val, 'm' typ from dual union all    select 16 u, 3624 val, 'm' typ from dual union all    select 17 u, 4056 val, 'm' typ from dual union all    select 18 u, 4504 val, 'm' typ from dual union all    select 19 u, 5016 val, 'm' typ from dual union all    select 20 u, 5352 val, 'm' typ from dual union all    select 21 u, 5712 val, 'm' typ from dual union all    select 22 u, 6256 val, 'm' typ from dual union all    select 23 u, 6880 val, 'm' typ from dual union all    select 24 u, 7312 val, 'm' typ from dual union all    select 25 u, 8000 val, 'm' typ from dual union all    select 26 u, 8496 val, 'm' typ from dual union all    select 27 u, 9024 val, 'm' typ from dual union all    select 28 u, 9544 val, 'm' typ from dual union all    select 29 u, 10136 val, 'm' typ from dual union all    select 30 u, 10984 val, 'm' typ from dual union all    select 31 u, 11640 val, 'm' typ from dual union all    select 32 u, 12328 val, 'm' typ from dual union all    select 33 u, 13048 val, 'm' typ from dual union all    select 34 u, 13800 val, 'm' typ from dual union all    select 35 u, 14496 val, 'm' typ from dual union all    select 36 u, 15312 val, 'm' typ from dual union all    select 37 u, 15936 val, 'm' typ from dual union all    select 38 u, 16816 val, 'm' typ from dual union all    select 39 u, 17728 val, 'm' typ from dual union all    select 40 u, 18672 val, 'm' typ from dual union all
  select 1 u, 104 val, 'q' typ from dual union all    select 2 u, 176 val, 'q' typ from dual union all    select 3 u, 272 val, 'q' typ from dual union all    select 4 u, 384 val, 'q' typ from dual union all    select 5 u, 496 val, 'q' typ from dual union all    select 6 u, 608 val, 'q' typ from dual union all    select 7 u, 704 val, 'q' typ from dual union all    select 8 u, 880 val, 'q' typ from dual union all    select 9 u, 1056 val, 'q' typ from dual union all    select 10 u, 1232 val, 'q' typ from dual union all    select 11 u, 1440 val, 'q' typ from dual union all    select 12 u, 1648 val, 'q' typ from dual union all    select 13 u, 1952 val, 'q' typ from dual union all    select 14 u, 2088 val, 'q' typ from dual union all    select 15 u, 2360 val, 'q' typ from dual union all    select 16 u, 2600 val, 'q' typ from dual union all    select 17 u, 2936 val, 'q' typ from dual union all    select 18 u, 3176 val, 'q' typ from dual union all    select 19 u, 3560 val, 'q' typ from dual union all    select 20 u, 3880 val, 'q' typ from dual union all    select 21 u, 4096 val, 'q' typ from dual union all    select 22 u, 4544 val, 'q' typ from dual union all    select 23 u, 4912 val, 'q' typ from dual union all    select 24 u, 5312 val, 'q' typ from dual union all    select 25 u, 5744 val, 'q' typ from dual union all    select 26 u, 6032 val, 'q' typ from dual union all    select 27 u, 6464 val, 'q' typ from dual union all    select 28 u, 6968 val, 'q' typ from dual union all    select 29 u, 7288 val, 'q' typ from dual union all    select 30 u, 7880 val, 'q' typ from dual union all    select 31 u, 8264 val, 'q' typ from dual union all    select 32 u, 8920 val, 'q' typ from dual union all    select 33 u, 9368 val, 'q' typ from dual union all    select 34 u, 9848 val, 'q' typ from dual union all    select 35 u, 10288 val, 'q' typ from dual union all    select 36 u, 10832 val, 'q' typ from dual union all    select 37 u, 11408 val, 'q' typ from dual union all    select 38 u, 12016 val, 'q' typ from dual union all    select 39 u, 12656 val, 'q' typ from dual union all    select 40 u, 13328 val, 'q' typ from dual union all
  select 1 u, 72 val, 'h' typ from dual union all    select 2 u, 128 val, 'h' typ from dual union all    select 3 u, 208 val, 'h' typ from dual union all    select 4 u, 288 val, 'h' typ from dual union all    select 5 u, 368 val, 'h' typ from dual union all    select 6 u, 480 val, 'h' typ from dual union all    select 7 u, 528 val, 'h' typ from dual union all    select 8 u, 688 val, 'h' typ from dual union all    select 9 u, 800 val, 'h' typ from dual union all    select 10 u, 976 val, 'h' typ from dual union all    select 11 u, 1120 val, 'h' typ from dual union all    select 12 u, 1264 val, 'h' typ from dual union all    select 13 u, 1440 val, 'h' typ from dual union all    select 14 u, 1576 val, 'h' typ from dual union all    select 15 u, 1784 val, 'h' typ from dual union all    select 16 u, 2024 val, 'h' typ from dual union all    select 17 u, 2264 val, 'h' typ from dual union all    select 18 u, 2504 val, 'h' typ from dual union all    select 19 u, 2728 val, 'h' typ from dual union all    select 20 u, 3080 val, 'h' typ from dual union all    select 21 u, 3248 val, 'h' typ from dual union all    select 22 u, 3536 val, 'h' typ from dual union all    select 23 u, 3712 val, 'h' typ from dual union all    select 24 u, 4112 val, 'h' typ from dual union all    select 25 u, 4304 val, 'h' typ from dual union all    select 26 u, 4768 val, 'h' typ from dual union all    select 27 u, 5024 val, 'h' typ from dual union all    select 28 u, 5288 val, 'h' typ from dual union all    select 29 u, 5608 val, 'h' typ from dual union all    select 30 u, 5960 val, 'h' typ from dual union all    select 31 u, 6344 val, 'h' typ from dual union all    select 32 u, 6760 val, 'h' typ from dual union all    select 33 u, 7208 val, 'h' typ from dual union all    select 34 u, 7688 val, 'h' typ from dual union all    select 35 u, 7888 val, 'h' typ from dual union all    select 36 u, 8432 val, 'h' typ from dual union all    select 37 u, 8768 val, 'h' typ from dual union all    select 38 u, 9136 val, 'h' typ from dual union all    select 39 u, 9776 val, 'h' typ from dual union all    select 40 u, 10208 val, 'h' typ from dual
  ) where val>nvl(p_l+4+decode(u,1,8,2,8,3,8,4,8,5,8,6,8,7,8,8,8,9,8,16),0) /*and typ='h'  здесь можно указать конкретно, какой уровень коррекции использовать или вынести в параметр*/ order by val,typ desc)
  where rownum=1)
  loop
  p_type:=s.typ;
  p_u:=s.u;
     
      select '0100'||lpad(make_qr.hex2bin(trim(to_char(length(make_qr.hex2bin(rawtohex(convert(p_text,'utf8')) ))/8,'XXXX'))) --make_qr.hex2bin(to_char(length(make_qr.hex2bin(rawtohex(convert(p_text,'utf8')) ))/8))
      ,decode(s.u,1,8,2,8,3,8,4,8,5,8,6,8,7,8,8,8,9,8,16),'0')||make_qr.hex2bin(rawtohex(convert(p_text,'utf8')) ) into p_b  from dual;
      if (mod(length(p_b),8)<>0) then
      p_b:=p_b||rpad('0',8-mod(length(p_b),8),'0');
      end if;
  
          p_v:=(s.val-length(p_b))/8;

          for i in 0 .. p_v-1 loop
          p_b:=p_b||p_tmp;
          if p_tmp='11101100' then p_tmp:='00010001'; else p_tmp:='11101100'; end if;
          end loop;
 
        --кол-во блоков, на которое бить
          for ss in (select u, val, typ from (
            select 1 u, 1 val, 'l' typ from dual union all    select 2 u, 1 val, 'l' typ from dual union all    select 3 u, 1 val, 'l' typ from dual union all    select 4 u, 1 val, 'l' typ from dual union all    select 5 u, 1 val, 'l' typ from dual union all    select 6 u, 2 val, 'l' typ from dual union all    select 7 u, 2 val, 'l' typ from dual union all    select 8 u, 2 val, 'l' typ from dual union all    select 9 u, 2 val, 'l' typ from dual union all    select 10 u, 4 val, 'l' typ from dual union all    select 11 u, 4 val, 'l' typ from dual union all    select 12 u, 4 val, 'l' typ from dual union all    select 13 u, 4 val, 'l' typ from dual union all    select 14 u, 4 val, 'l' typ from dual union all    select 15 u, 6 val, 'l' typ from dual union all    select 16 u, 6 val, 'l' typ from dual union all    select 17 u, 6 val, 'l' typ from dual union all    select 18 u, 6 val, 'l' typ from dual union all    select 19 u, 7 val, 'l' typ from dual union all    select 20 u, 8 val, 'l' typ from dual union all    select 21 u, 8 val, 'l' typ from dual union all    select 22 u, 9 val, 'l' typ from dual union all    select 23 u, 9 val, 'l' typ from dual union all    select 24 u, 10 val, 'l' typ from dual union all    select 25 u, 12 val, 'l' typ from dual union all    select 26 u, 12 val, 'l' typ from dual union all    select 27 u, 12 val, 'l' typ from dual union all    select 28 u, 13 val, 'l' typ from dual union all    select 29 u, 14 val, 'l' typ from dual union all    select 30 u, 15 val, 'l' typ from dual union all    select 31 u, 16 val, 'l' typ from dual union all    select 32 u, 17 val, 'l' typ from dual union all    select 33 u, 18 val, 'l' typ from dual union all    select 34 u, 19 val, 'l' typ from dual union all    select 35 u, 19 val, 'l' typ from dual union all    select 36 u, 20 val, 'l' typ from dual union all    select 37 u, 21 val, 'l' typ from dual union all    select 38 u, 22 val, 'l' typ from dual union all    select 39 u, 24 val, 'l' typ from dual union all    select 40 u, 25 val, 'l' typ from dual union all
            select 1 u, 1 val, 'm' typ from dual union all    select 2 u, 1 val, 'm' typ from dual union all    select 3 u, 1 val, 'm' typ from dual union all    select 4 u, 2 val, 'm' typ from dual union all    select 5 u, 2 val, 'm' typ from dual union all    select 6 u, 4 val, 'm' typ from dual union all    select 7 u, 4 val, 'm' typ from dual union all    select 8 u, 4 val, 'm' typ from dual union all    select 9 u, 5 val, 'm' typ from dual union all    select 10 u, 5 val, 'm' typ from dual union all    select 11 u, 5 val, 'm' typ from dual union all    select 12 u, 8 val, 'm' typ from dual union all    select 13 u, 9 val, 'm' typ from dual union all    select 14 u, 9 val, 'm' typ from dual union all    select 15 u, 10 val, 'm' typ from dual union all    select 16 u, 10 val, 'm' typ from dual union all    select 17 u, 11 val, 'm' typ from dual union all    select 18 u, 13 val, 'm' typ from dual union all    select 19 u, 14 val, 'm' typ from dual union all    select 20 u, 16 val, 'm' typ from dual union all    select 21 u, 17 val, 'm' typ from dual union all    select 22 u, 17 val, 'm' typ from dual union all    select 23 u, 18 val, 'm' typ from dual union all    select 24 u, 20 val, 'm' typ from dual union all    select 25 u, 21 val, 'm' typ from dual union all    select 26 u, 23 val, 'm' typ from dual union all    select 27 u, 25 val, 'm' typ from dual union all    select 28 u, 26 val, 'm' typ from dual union all    select 29 u, 28 val, 'm' typ from dual union all    select 30 u, 29 val, 'm' typ from dual union all    select 31 u, 31 val, 'm' typ from dual union all    select 32 u, 33 val, 'm' typ from dual union all    select 33 u, 35 val, 'm' typ from dual union all    select 34 u, 37 val, 'm' typ from dual union all    select 35 u, 38 val, 'm' typ from dual union all    select 36 u, 40 val, 'm' typ from dual union all    select 37 u, 43 val, 'm' typ from dual union all    select 38 u, 45 val, 'm' typ from dual union all    select 39 u, 47 val, 'm' typ from dual union all    select 40 u, 49 val, 'm' typ from dual union all
            select 1 u, 1 val, 'q' typ from dual union all    select 2 u, 1 val, 'q' typ from dual union all    select 3 u, 2 val, 'q' typ from dual union all    select 4 u, 2 val, 'q' typ from dual union all    select 5 u, 4 val, 'q' typ from dual union all    select 6 u, 4 val, 'q' typ from dual union all    select 7 u, 6 val, 'q' typ from dual union all    select 8 u, 6 val, 'q' typ from dual union all    select 9 u, 8 val, 'q' typ from dual union all    select 10 u, 8 val, 'q' typ from dual union all    select 11 u, 8 val, 'q' typ from dual union all    select 12 u, 10 val, 'q' typ from dual union all    select 13 u, 12 val, 'q' typ from dual union all    select 14 u, 16 val, 'q' typ from dual union all    select 15 u, 12 val, 'q' typ from dual union all    select 16 u, 17 val, 'q' typ from dual union all    select 17 u, 16 val, 'q' typ from dual union all    select 18 u, 18 val, 'q' typ from dual union all    select 19 u, 21 val, 'q' typ from dual union all    select 20 u, 20 val, 'q' typ from dual union all    select 21 u, 23 val, 'q' typ from dual union all    select 22 u, 23 val, 'q' typ from dual union all    select 23 u, 25 val, 'q' typ from dual union all    select 24 u, 27 val, 'q' typ from dual union all    select 25 u, 29 val, 'q' typ from dual union all    select 26 u, 34 val, 'q' typ from dual union all    select 27 u, 34 val, 'q' typ from dual union all    select 28 u, 35 val, 'q' typ from dual union all    select 29 u, 38 val, 'q' typ from dual union all    select 30 u, 40 val, 'q' typ from dual union all    select 31 u, 43 val, 'q' typ from dual union all    select 32 u, 45 val, 'q' typ from dual union all    select 33 u, 48 val, 'q' typ from dual union all    select 34 u, 51 val, 'q' typ from dual union all    select 35 u, 53 val, 'q' typ from dual union all    select 36 u, 56 val, 'q' typ from dual union all    select 37 u, 59 val, 'q' typ from dual union all    select 38 u, 62 val, 'q' typ from dual union all    select 39 u, 65 val, 'q' typ from dual union all    select 40 u, 68 val, 'q' typ from dual union all
            select 1 u, 1 val, 'h' typ from dual union all    select 2 u, 1 val, 'h' typ from dual union all    select 3 u, 2 val, 'h' typ from dual union all    select 4 u, 4 val, 'h' typ from dual union all    select 5 u, 4 val, 'h' typ from dual union all    select 6 u, 4 val, 'h' typ from dual union all    select 7 u, 5 val, 'h' typ from dual union all    select 8 u, 6 val, 'h' typ from dual union all    select 9 u, 8 val, 'h' typ from dual union all    select 10 u, 8 val, 'h' typ from dual union all    select 11 u, 11 val, 'h' typ from dual union all    select 12 u, 11 val, 'h' typ from dual union all    select 13 u, 16 val, 'h' typ from dual union all    select 14 u, 16 val, 'h' typ from dual union all    select 15 u, 18 val, 'h' typ from dual union all    select 16 u, 16 val, 'h' typ from dual union all    select 17 u, 19 val, 'h' typ from dual union all    select 18 u, 21 val, 'h' typ from dual union all    select 19 u, 25 val, 'h' typ from dual union all    select 20 u, 25 val, 'h' typ from dual union all    select 21 u, 25 val, 'h' typ from dual union all    select 22 u, 34 val, 'h' typ from dual union all    select 23 u, 30 val, 'h' typ from dual union all    select 24 u, 32 val, 'h' typ from dual union all    select 25 u, 35 val, 'h' typ from dual union all    select 26 u, 37 val, 'h' typ from dual union all    select 27 u, 40 val, 'h' typ from dual union all    select 28 u, 42 val, 'h' typ from dual union all    select 29 u, 45 val, 'h' typ from dual union all    select 30 u, 48 val, 'h' typ from dual union all    select 31 u, 51 val, 'h' typ from dual union all    select 32 u, 54 val, 'h' typ from dual union all    select 33 u, 57 val, 'h' typ from dual union all    select 34 u, 60 val, 'h' typ from dual union all    select 35 u, 63 val, 'h' typ from dual union all    select 36 u, 66 val, 'h' typ from dual union all    select 37 u, 70 val, 'h' typ from dual union all    select 38 u, 74 val, 'h' typ from dual union all    select 39 u, 77 val, 'h' typ from dual union all    select 40 u, 81 val, 'h' typ from dual
              ) where u=s.u and typ=s.typ )
              loop
               p_v:=ss.val;--p_v=кол-во блоков
              end loop;
                count_byte:=(s.val/8)/p_v;
                ostatok_mod:=p_v-mod(s.val/8,p_v);
                if p_v>1 then
                count_byte:=/*round*/trunc((s.val/8)/p_v);
                ostatok_mod:=p_v-mod((s.val/8),p_v);-- +1 (блоки нумеруем с 0);--с какого номера блока увеличивать на 1 байт
                end if;
  STD.DEBUG_MESSAGE('make_qr', s.u||' '||s.typ||' '||p_v||' '||count_byte||' '||ostatok_mod||' '||SQLCODE||SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);

            --кол-во байтов коррекции на один блок
            for ss in (
              select * from (
                select 1 u, 7 val, 'l' typ from dual union all    select 2 u, 10 val, 'l' typ from dual union all    select 3 u, 15 val, 'l' typ from dual union all    select 4 u, 20 val, 'l' typ from dual union all    select 5 u, 26 val, 'l' typ from dual union all    select 6 u, 18 val, 'l' typ from dual union all    select 7 u, 20 val, 'l' typ from dual union all    select 8 u, 24 val, 'l' typ from dual union all    select 9 u, 30 val, 'l' typ from dual union all    select 10 u, 18 val, 'l' typ from dual union all    select 11 u, 20 val, 'l' typ from dual union all    select 12 u, 24 val, 'l' typ from dual union all    select 13 u, 26 val, 'l' typ from dual union all    select 14 u, 30 val, 'l' typ from dual union all    select 15 u, 22 val, 'l' typ from dual union all    select 16 u, 24 val, 'l' typ from dual union all    select 17 u, 28 val, 'l' typ from dual union all    select 18 u, 30 val, 'l' typ from dual union all    select 19 u, 28 val, 'l' typ from dual union all    select 20 u, 28 val, 'l' typ from dual union all    select 21 u, 28 val, 'l' typ from dual union all    select 22 u, 28 val, 'l' typ from dual union all    select 23 u, 30 val, 'l' typ from dual union all    select 24 u, 30 val, 'l' typ from dual union all    select 25 u, 26 val, 'l' typ from dual union all    select 26 u, 28 val, 'l' typ from dual union all    select 27 u, 30 val, 'l' typ from dual union all    select 28 u, 30 val, 'l' typ from dual union all    select 29 u, 30 val, 'l' typ from dual union all    select 30 u, 30 val, 'l' typ from dual union all    select 31 u, 30 val, 'l' typ from dual union all    select 32 u, 30 val, 'l' typ from dual union all    select 33 u, 30 val, 'l' typ from dual union all    select 34 u, 30 val, 'l' typ from dual union all    select 35 u, 30 val, 'l' typ from dual union all    select 36 u, 30 val, 'l' typ from dual union all    select 37 u, 30 val, 'l' typ from dual union all    select 38 u, 30 val, 'l' typ from dual union all    select 39 u, 30 val, 'l' typ from dual union all    select 40 u, 30 val, 'l' typ from dual union all
                select 1 u, 10 val, 'm' typ from dual union all    select 2 u, 16 val, 'm' typ from dual union all    select 3 u, 26 val, 'm' typ from dual union all    select 4 u, 18 val, 'm' typ from dual union all    select 5 u, 24 val, 'm' typ from dual union all    select 6 u, 16 val, 'm' typ from dual union all    select 7 u, 18 val, 'm' typ from dual union all    select 8 u, 22 val, 'm' typ from dual union all    select 9 u, 22 val, 'm' typ from dual union all    select 10 u, 26 val, 'm' typ from dual union all    select 11 u, 30 val, 'm' typ from dual union all    select 12 u, 22 val, 'm' typ from dual union all    select 13 u, 22 val, 'm' typ from dual union all    select 14 u, 24 val, 'm' typ from dual union all    select 15 u, 24 val, 'm' typ from dual union all    select 16 u, 28 val, 'm' typ from dual union all    select 17 u, 28 val, 'm' typ from dual union all    select 18 u, 26 val, 'm' typ from dual union all    select 19 u, 26 val, 'm' typ from dual union all    select 20 u, 26 val, 'm' typ from dual union all    select 21 u, 26 val, 'm' typ from dual union all    select 22 u, 28 val, 'm' typ from dual union all    select 23 u, 28 val, 'm' typ from dual union all    select 24 u, 28 val, 'm' typ from dual union all    select 25 u, 28 val, 'm' typ from dual union all    select 26 u, 28 val, 'm' typ from dual union all    select 27 u, 28 val, 'm' typ from dual union all    select 28 u, 28 val, 'm' typ from dual union all    select 29 u, 28 val, 'm' typ from dual union all    select 30 u, 28 val, 'm' typ from dual union all    select 31 u, 28 val, 'm' typ from dual union all    select 32 u, 28 val, 'm' typ from dual union all    select 33 u, 28 val, 'm' typ from dual union all    select 34 u, 28 val, 'm' typ from dual union all    select 35 u, 28 val, 'm' typ from dual union all    select 36 u, 28 val, 'm' typ from dual union all    select 37 u, 28 val, 'm' typ from dual union all    select 38 u, 28 val, 'm' typ from dual union all    select 39 u, 28 val, 'm' typ from dual union all    select 40 u, 28 val, 'm' typ from dual union all
                select 1 u, 13 val, 'q' typ from dual union all    select 2 u, 22 val, 'q' typ from dual union all    select 3 u, 18 val, 'q' typ from dual union all    select 4 u, 26 val, 'q' typ from dual union all    select 5 u, 18 val, 'q' typ from dual union all    select 6 u, 24 val, 'q' typ from dual union all    select 7 u, 18 val, 'q' typ from dual union all    select 8 u, 22 val, 'q' typ from dual union all    select 9 u, 20 val, 'q' typ from dual union all    select 10 u, 24 val, 'q' typ from dual union all    select 11 u, 28 val, 'q' typ from dual union all    select 12 u, 26 val, 'q' typ from dual union all    select 13 u, 24 val, 'q' typ from dual union all    select 14 u, 20 val, 'q' typ from dual union all    select 15 u, 30 val, 'q' typ from dual union all    select 16 u, 24 val, 'q' typ from dual union all    select 17 u, 28 val, 'q' typ from dual union all    select 18 u, 28 val, 'q' typ from dual union all    select 19 u, 26 val, 'q' typ from dual union all    select 20 u, 30 val, 'q' typ from dual union all    select 21 u, 28 val, 'q' typ from dual union all    select 22 u, 30 val, 'q' typ from dual union all    select 23 u, 30 val, 'q' typ from dual union all    select 24 u, 30 val, 'q' typ from dual union all    select 25 u, 30 val, 'q' typ from dual union all    select 26 u, 28 val, 'q' typ from dual union all    select 27 u, 30 val, 'q' typ from dual union all    select 28 u, 30 val, 'q' typ from dual union all    select 29 u, 30 val, 'q' typ from dual union all    select 30 u, 30 val, 'q' typ from dual union all    select 31 u, 30 val, 'q' typ from dual union all    select 32 u, 30 val, 'q' typ from dual union all    select 33 u, 30 val, 'q' typ from dual union all    select 34 u, 30 val, 'q' typ from dual union all    select 35 u, 30 val, 'q' typ from dual union all    select 36 u, 30 val, 'q' typ from dual union all    select 37 u, 30 val, 'q' typ from dual union all    select 38 u, 30 val, 'q' typ from dual union all    select 39 u, 30 val, 'q' typ from dual union all    select 40 u, 30 val, 'q' typ from dual union all
                select 1 u, 17 val, 'h' typ from dual union all    select 2 u, 28 val, 'h' typ from dual union all    select 3 u, 22 val, 'h' typ from dual union all    select 4 u, 16 val, 'h' typ from dual union all    select 5 u, 22 val, 'h' typ from dual union all    select 6 u, 28 val, 'h' typ from dual union all    select 7 u, 26 val, 'h' typ from dual union all    select 8 u, 26 val, 'h' typ from dual union all    select 9 u, 24 val, 'h' typ from dual union all    select 10 u, 28 val, 'h' typ from dual union all    select 11 u, 24 val, 'h' typ from dual union all    select 12 u, 28 val, 'h' typ from dual union all    select 13 u, 22 val, 'h' typ from dual union all    select 14 u, 24 val, 'h' typ from dual union all    select 15 u, 24 val, 'h' typ from dual union all    select 16 u, 30 val, 'h' typ from dual union all    select 17 u, 28 val, 'h' typ from dual union all    select 18 u, 28 val, 'h' typ from dual union all    select 19 u, 26 val, 'h' typ from dual union all    select 20 u, 28 val, 'h' typ from dual union all    select 21 u, 30 val, 'h' typ from dual union all    select 22 u, 24 val, 'h' typ from dual union all    select 23 u, 30 val, 'h' typ from dual union all    select 24 u, 30 val, 'h' typ from dual union all    select 25 u, 30 val, 'h' typ from dual union all    select 26 u, 30 val, 'h' typ from dual union all    select 27 u, 30 val, 'h' typ from dual union all    select 28 u, 30 val, 'h' typ from dual union all    select 29 u, 30 val, 'h' typ from dual union all    select 30 u, 30 val, 'h' typ from dual union all    select 31 u, 30 val, 'h' typ from dual union all    select 32 u, 30 val, 'h' typ from dual union all    select 33 u, 30 val, 'h' typ from dual union all    select 34 u, 30 val, 'h' typ from dual union all    select 35 u, 30 val, 'h' typ from dual union all    select 36 u, 30 val, 'h' typ from dual union all    select 37 u, 30 val, 'h' typ from dual union all    select 38 u, 30 val, 'h' typ from dual union all    select 39 u, 30 val, 'h' typ from dual union all    select 40 u, 30 val, 'h' typ from dual
                ) where u=s.u and typ=s.typ )
            loop
            korr_byte:=ss.val;
            end loop;
            
          case   
            when korr_byte=7 then 
            korr_mnogochlen:='87, 229, 146, 149, 238, 102, 21';        
            when korr_byte=10 then  
            korr_mnogochlen:='251, 67, 46, 61, 118, 70, 64, 94, 32, 45';             
            when korr_byte=13 then  
            korr_mnogochlen:='74, 152, 176, 100, 86, 100, 106, 104, 130, 218, 206, 140, 78';
            when korr_byte=15 then 
            korr_mnogochlen:='8, 183, 61, 91, 202, 37, 51, 58, 58, 237, 140, 124, 5, 99, 105';
            when korr_byte=16 then  
            korr_mnogochlen:='120, 104, 107, 109, 102, 161, 76, 3, 91, 191, 147, 169, 182, 194, 225, 120';
            when korr_byte=17 then 
            korr_mnogochlen:='43, 139, 206, 78, 43, 239, 123, 206, 214, 147, 24, 99, 150, 39, 243, 163, 136';
            when korr_byte=18 then  
            korr_mnogochlen:='215, 234, 158, 94, 184, 97, 118, 170, 79, 187, 152, 148, 252, 179, 5, 98, 96, 153';
            when korr_byte=20 then 
            korr_mnogochlen:='17, 60, 79, 50, 61, 163, 26, 187, 202, 180, 221, 225, 83, 239, 156, 164, 212, 212, 188, 190';
            when korr_byte=22 then  
            korr_mnogochlen:='210, 171, 247, 242, 93, 230, 14, 109, 221, 53, 200, 74, 8, 172, 98, 80, 219, 134, 160, 105, 165, 231'; 
            when korr_byte=24 then 
            korr_mnogochlen:='229, 121, 135, 48, 211, 117, 251, 126, 159, 180, 169, 152, 192, 226, 228, 218, 111, 0, 117, 232, 87, 96, 227, 21';
            when korr_byte=26 then  
            korr_mnogochlen:='173, 125, 158, 2, 103, 182, 118, 17, 145, 201, 111, 28, 165, 53, 161, 21, 245, 142, 13, 102, 48, 227, 153, 145, 218, 70';
            when korr_byte=28 then  
            korr_mnogochlen:='168, 223, 200, 104, 224, 234, 108, 180, 110, 190, 195, 147, 205, 27, 232, 201, 21, 43, 245, 87, 42, 195, 212, 119, 242, 37, 9, 123';                                             
            when korr_byte=30 then 
            korr_mnogochlen:='41, 173, 145, 152, 216, 31, 179, 182, 50, 48, 110, 86, 239, 96, 222, 125, 42, 173, 226, 193, 224, 130, 156, 37, 251, 216, 238, 40, 192, 180'; 
          end case;
          
            --перевод корректирующго многочлена в двоичную систему (по 8 бит)
            FOR i IN 1..korr_byte LOOP
            korr_mnogochlen_bin:=korr_mnogochlen_bin||lpad( make_qr.hex2bin(make_qr.dec2hex( REGEXP_substr(korr_mnogochlen,'[^,]+',1,i)) ) ,8,'0');--lpad( hex2bin(dec2hex( REGEXP_substr(korr_mnogochlen,'[^,]+',1,i)) ) ) ,8,'0');
            END LOOP;
  --STD.DEBUG_MESSAGE('make_qr', 'korr_mnogochlen_bin='||korr_mnogochlen_bin);
     
       tmp:=0; 
      count_byte1:=count_byte;
      korr_mnogochlen_tutto:=''; aaa_tmp:='';
      --формирую все корректирующие байты для всех блоков
      for i in 0 .. p_v-1 loop
      
      if i>=ostatok_mod then count_byte1:=count_byte+1; else count_byte1:=count_byte; end if;
   
            korr_mnogochlen_bin_tmp:='';
            korr_mn:='';
            aaa_tmp:=substr(p_b,tmp*8+1,count_byte1*8);
     
                for iii in 0 .. /*max_2(count_byte1,korr_byte)*/count_byte1-1 loop
    
                fff:=nvl(substr(aaa_tmp,1,8),'00000000');
              
                       if bin2dec(fff)<>0 then 
                        d:=bin2dec(fff); 
                        dgi:=galua_inv(d); 
                       
                        korr_mnogochlen_bin_tmp:='';
                            for j in 0 .. korr_byte-1 loop
                            
                            korr_mnogochlen_bin_tmp:=korr_mnogochlen_bin_tmp||
                            lpad(make_qr.hex2bin(trim(to_char(
                            mod(bin2dec(substr(korr_mnogochlen_bin/*korr_mn*/,j*8+1,8))+dgi,255)
                            ,'XXXX'))),8,'0');
                            end loop; 
                        korr_mn:=korr_mnogochlen_bin_tmp;    
                        korr_mnogochlen_bin_tmp:='';
                            for j in 0 .. korr_byte-1 loop
                           
                            korr_mnogochlen_bin_tmp:=korr_mnogochlen_bin_tmp||
                            lpad(make_qr.hex2bin(trim(to_char(
                            galua(bin2dec(substr(/*korr_mnogochlen_bin*/korr_mn,j*8+1,8)) )
                            ,'XXXX'))),8,'0');
                            end loop; 
                        korr_mn:=korr_mnogochlen_bin_tmp;    
                        korr_mnogochlen_bin_tmp:='';    
                            for j in 0 .. /*korr_byte*/max_2(count_byte1,korr_byte)-1 loop
                                p_tmp:=substr(aaa_tmp,/*iii*8+*/(j+1)*8+1,8); if p_tmp is null then p_tmp:='00000000'; end if;
                                aaa:='';  aaa:=substr(/*korr_mnogochlen_bin*/korr_mn,j*8+1,8); if aaa is null then aaa:='00000000'; end if;
                                korr_mnogochlen_bin_tmp:=korr_mnogochlen_bin_tmp||
                                bin_xor_bin(aaa,p_tmp ) ;
                            end loop;
                            aaa_tmp:=korr_mnogochlen_bin_tmp;
                        korr_mn:=korr_mnogochlen_bin_tmp;    
                        korr_mnogochlen_bin_tmp:='';     
                       else
                 
                         aaa_tmp:=substr(aaa_tmp,9); 
                       end if;
                end loop;
               
            korr_mnogochlen_tutto:=korr_mnogochlen_tutto||substr(aaa_tmp,1,korr_byte*8);--korr_mn;
           
            tmp:=tmp+count_byte1;
        
      end loop; 
      aaa_tmp:='';aaa:='';
      --тусую байты данных с корр байтами - должен получиться итоговый массив для отрисовки
      tutto:=''; --данные
      p_b_tmp:=''; count_byte1:=count_byte; tmp:=0; d:=0;
            if ostatok_mod<p_v then d:=1; else d:=0; end if;

     for ii in 0 .. count_byte+d-1 loop
     tmp:=0;
                 for i in 0 .. p_v-1 loop
                 if i>=ostatok_mod then count_byte1:=count_byte+1; else count_byte1:=count_byte; end if;
                        p_b_tmp:=substr(p_b,tmp*8+1,count_byte1*8);
                        aaa_tmp:=substr(p_b_tmp,ii*8+1 ,8); if aaa_tmp is null then aaa_tmp:=''; end if;
                        tutto:=tutto||aaa_tmp;
                        tmp:=tmp+count_byte1;
                 end loop;
     end loop;   
     aaa_tmp:='';aaa:='';         
      
       --корр многочлен 
      p_b_tmp:='';  tmp:=0; d:=0;

     for ii in 0 .. korr_byte-1 loop
     tmp:=0;
                 for i in 0 .. p_v-1 loop
                
                        p_b_tmp:=substr(korr_mnogochlen_tutto,tmp*8+1,korr_byte*8);
                        aaa_tmp:=substr(p_b_tmp,ii*8+1 ,8); if aaa_tmp is null then aaa_tmp:=''; end if;
                        tutto:=tutto||aaa_tmp;
                        tmp:=tmp+korr_byte;
                 end loop;
     end loop;   
     aaa_tmp:='';aaa:='';  
       
       
       --рисуем массив 0-белый квадрат 1-черный
       case   
            when s.u=2 then poisk_coor:='18'; count_poisk:=1;   
            when s.u=3 then poisk_coor:='22'; count_poisk:=1;
            when s.u=4 then poisk_coor:='26'; count_poisk:=1; 
            when s.u=5 then poisk_coor:='30'; count_poisk:=1; 
            when s.u=6 then poisk_coor:='34'; count_poisk:=1; 
            when s.u=7 then poisk_coor:='6, 22, 38'; count_poisk:=3; 
            when s.u=8 then poisk_coor:='6, 24, 42'; count_poisk:=3; 
            when s.u=9 then poisk_coor:='6, 26, 46'; count_poisk:=3; 
            when s.u=10 then poisk_coor:='6, 28, 50'; count_poisk:=3; 
            when s.u=11 then poisk_coor:='6, 30, 54'; count_poisk:=3; 
            when s.u=12 then poisk_coor:='6, 32, 58'; count_poisk:=3;
            when s.u=13 then poisk_coor:='6, 34, 62'; count_poisk:=3; 
            when s.u=14 then poisk_coor:='6, 26, 46, 66'; count_poisk:=4; 
            when s.u=15 then poisk_coor:='6, 26, 48, 70'; count_poisk:=4;
            when s.u=16 then poisk_coor:='6, 26, 50, 74'; count_poisk:=4;
            when s.u=17 then poisk_coor:='6, 30, 54, 78'; count_poisk:=4;
            when s.u=18 then poisk_coor:='6, 30, 56, 82'; count_poisk:=4;
            when s.u=19 then poisk_coor:='6, 30, 58, 86'; count_poisk:=4;
            when s.u=20 then poisk_coor:='6, 34, 62, 90'; count_poisk:=4;
            when s.u=21 then poisk_coor:='6, 28, 50, 72, 94'; count_poisk:=5;
            when s.u=22 then poisk_coor:='6, 26, 50, 74, 98'; count_poisk:=5;
            when s.u=23 then poisk_coor:='6, 30, 54, 78, 102'; count_poisk:=5;
            when s.u=24 then poisk_coor:='6, 28, 54, 80, 106'; count_poisk:=5;
            when s.u=25 then poisk_coor:='6, 32, 58, 84, 110'; count_poisk:=5;
            when s.u=26 then poisk_coor:='6, 30, 58, 86, 114'; count_poisk:=5;
            when s.u=27 then poisk_coor:='6, 34, 62, 90, 118'; count_poisk:=5;
            when s.u=28 then poisk_coor:='6, 26, 50, 74, 98, 122'; count_poisk:=6;
            when s.u=29 then poisk_coor:='6, 30, 54, 78, 102, 126'; count_poisk:=6;
            when s.u=30 then poisk_coor:='6, 26, 52, 78, 104, 130'; count_poisk:=6;
            when s.u=31 then poisk_coor:='6, 30, 56, 82, 108, 134'; count_poisk:=6;
            when s.u=32 then poisk_coor:='6, 34, 60, 86, 112, 138'; count_poisk:=6;
            when s.u=33 then poisk_coor:='6, 30, 58, 86, 114, 142'; count_poisk:=6;
            when s.u=34 then poisk_coor:='6, 34, 62, 90, 118, 146'; count_poisk:=6;
            when s.u=35 then poisk_coor:='6, 30, 54, 78, 102, 126, 150'; count_poisk:=7;
            when s.u=36 then poisk_coor:='6, 24, 50, 76, 102, 128, 154'; count_poisk:=7;
            when s.u=37 then poisk_coor:='6, 28, 54, 80, 106, 132, 158'; count_poisk:=7;
            when s.u=38 then poisk_coor:='6, 32, 58, 84, 110, 136, 162'; count_poisk:=7;
            when s.u=39 then poisk_coor:='6, 26, 54, 82, 110, 138, 166'; count_poisk:=7;
            when s.u=40 then poisk_coor:='6, 30, 58, 86, 114, 142, 170'; count_poisk:=7;
            when s.u=1 then count_poisk:=0; poisk_coor:='-';
          end case;
          
       quadro:=21 + (s.u-1)*4;
       
       for i in 1..quadro loop
            for j in 1..quadro loop
            draw:=draw||'-';
            end loop;
            draw:=draw||'
';
       end loop; 

       if count_poisk<>0 then
           FOR i IN 1..count_poisk LOOP
           if i=1 then mincoor:=to_number(REGEXP_substr(poisk_coor,'[^,]+',1,i)); end if;
           if i=count_poisk then maxcoor:=to_number(REGEXP_substr(poisk_coor,'[^,]+',1,i)); end if;
           end loop;
      
     
           FOR i IN 1..count_poisk LOOP
               
                    m:=to_number(REGEXP_substr(poisk_coor,'[^,]+',1,i));
                    for j in 1 .. count_poisk loop
                    n:=to_number(REGEXP_substr(poisk_coor,'[^,]+',1,j));
                        if  not ((m=mincoor and n=mincoor) or (m=mincoor and n=maxcoor) or (m=maxcoor and n=mincoor)) or mincoor=maxcoor
                        then 
                            for k in 1 .. quadro loop
                                for kk in 1 .. (quadro+1) loop
                                    if m=k and n=kk then 
                                     --STD.DEBUG_MESSAGE('make_qr', m||' '||n||' '||SQLCODE||SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);  
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*k+1+kk, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*k+1+kk+1, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*k+1+kk-1, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k-1)+1+kk-1, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k-1)+1+kk, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k-1)+1+kk+1, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k+1)+1+kk-1, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k+1)+1+kk, 1);
                                    draw:= regexp_replace(draw,'.','0', (quadro+1)*(k+1)+1+kk+1, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-2)+1+kk-2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-2)+1+kk-1, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-2)+1+kk, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-2)+1+kk+1, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-2)+1+kk+2, 1);
                                    
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+2)+1+kk-2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+2)+1+kk-1, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+2)+1+kk, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+2)+1+kk+1, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+2)+1+kk+2, 1);
                                    
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-1)+1+kk-2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*k+1+kk-2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+1)+1+kk-2, 1);
                                    
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k-1)+1+kk+2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*k+1+kk+2, 1);
                                    draw:= regexp_replace(draw,'.','1', (quadro+1)*(k+1)+1+kk+2, 1);
                                    end if; 
                                end loop;
                            end loop;
                        end if;
                    end loop;            
           END LOOP;
       end if;
       
      -- STD.DEBUG_MESSAGE('make_qr',substr(draw,1,2000));--||' '||SQLCODE||SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE); 
       --поисковые узоры в углах
       
         --левый верхний
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+1+4, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+1+4, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+1+4, 1);
            
            draw:= regexp_replace(draw,'.','1', 1, 1);
            draw:= regexp_replace(draw,'.','1', 2, 1);
            draw:= regexp_replace(draw,'.','1', 3, 1);
            draw:= regexp_replace(draw,'.','1', 4, 1);
            draw:= regexp_replace(draw,'.','1', 5, 1);
            draw:= regexp_replace(draw,'.','1', 6, 1);
            draw:= regexp_replace(draw,'.','1', 7, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*2+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*3+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*4+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*5+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*2+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*3+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*4+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*5+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+6, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+2, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+3, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+4, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+6, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+1+7, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+1+1, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  8, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*6+1+7, 1);
            
            --правый верхний
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*3+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*4+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*2+(quadro-4), 1);
            
            draw:= regexp_replace(draw,'.','1', quadro, 1);
            draw:= regexp_replace(draw,'.','1', quadro-1, 1);
            draw:= regexp_replace(draw,'.','1', quadro-2, 1);
            draw:= regexp_replace(draw,'.','1', quadro-3, 1);
            draw:= regexp_replace(draw,'.','1', quadro-4, 1);
            draw:= regexp_replace(draw,'.','1', quadro-5, 1);
            draw:= regexp_replace(draw,'.','1', quadro-6, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)+quadro, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*2+quadro, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*3+quadro, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*4+quadro, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*5+quadro, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+quadro, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*2+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*3+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*4+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*5+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-6), 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*6+(quadro-5), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-5), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-5), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+quadro, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-2), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-3), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-4), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-5), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-6), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*7+(quadro-7), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+(quadro-1), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+(quadro-1), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+(quadro-5), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+(quadro-5), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+(quadro-5), 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)+(quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*2+(quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*3+(quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*4+(quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*5+(quadro-7), 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*6+(quadro-7), 1);
            
            --левый нижний
           draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-4)+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-4)+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-4)+1+4, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-3)+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-3)+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-3)+1+4, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-5)+1+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-5)+1+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-5)+1+4, 1);
            
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+1, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+2, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+3, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+4, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+5, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+6, 1);
            draw:= regexp_replace(draw,'.','1', (quadro+1)*(quadro-1)+7, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-2)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-3)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-4)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-5)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-6)+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-2)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-3)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-4)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-5)+1+6, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-6)+1+6, 1);
            
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+1, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+2, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+3, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+4, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-7)+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+2, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+3, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+4, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+6, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-8)+1+7, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-3)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-4)+1+1, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-5)+1+1, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-3)+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-4)+1+5, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-5)+1+5, 1);
            
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-1)+8, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-2)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-3)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-4)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-5)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-6)+1+7, 1);
            draw:= regexp_replace(draw,'.','0',  (quadro+1)*(quadro-7)+1+7, 1);

         --полосы синхронизации
               p_tmp:='1';mincoor:=6;
                for kk in 8 .. (quadro-8) loop
                draw:= regexp_replace(draw,'.',p_tmp, (quadro+1)*kk+1+mincoor, 1);
                if p_tmp='1' then p_tmp:='0'; else p_tmp:='1'; end if;
                end loop;
                
                p_tmp:='1';
                for kk in 8 .. (quadro-8) loop
                draw:= regexp_replace(draw,'.',p_tmp, (quadro+1)*mincoor+1+kk, 1);
                if p_tmp='1' then p_tmp:='0'; else p_tmp:='1'; end if;
                end loop;
              
              --код версии
              if s.u>6 then
                  case   
                    when s.u=7 then kod_versii:='000010011110100110'; 
                    when s.u=8 then kod_versii:='010001011100111000';
                    when s.u=9 then kod_versii:='110111011000000100'; 
                    when s.u=10 then kod_versii:='101001111110000000';
                    when s.u=11 then kod_versii:='001111111010111100';
                    when s.u=12 then kod_versii:='001101100100011010';
                    when s.u=13 then kod_versii:='101011100000100110';
                    when s.u=14 then kod_versii:='110101000110100010';
                    when s.u=15 then kod_versii:='010011000010011110';
                    when s.u=16 then kod_versii:='011100010001011100';
                    when s.u=17 then kod_versii:='111010010101100000';
                    when s.u=18 then kod_versii:='100100110011100100';
                    when s.u=19 then kod_versii:='000010110111011000';
                    when s.u=20 then kod_versii:='000000101001111110';
                    when s.u=21 then kod_versii:='100110101101000010';
                    when s.u=22 then kod_versii:='111000001011000110';
                    when s.u=23 then kod_versii:='011110001111111010';
                    when s.u=24 then kod_versii:='001101001101100100';
                    when s.u=25 then kod_versii:='101011001001011000';
                    when s.u=26 then kod_versii:='110101101111011100';
                    when s.u=27 then kod_versii:='010011101011100000';
                    when s.u=28 then kod_versii:='010001110101000110';
                    when s.u=29 then kod_versii:='110111110001111010';
                    when s.u=30 then kod_versii:='101001010111111110';
                    when s.u=31 then kod_versii:='001111010011000010';
                    when s.u=32 then kod_versii:='101000011000101101';
                    when s.u=33 then kod_versii:='001110011100010001';
                    when s.u=34 then kod_versii:='010000111010010101';
                    when s.u=35 then kod_versii:='110110111110101001';
                    when s.u=36 then kod_versii:='110100100000001111';
                    when s.u=37 then kod_versii:='010010100100110011';
                    when s.u=38 then kod_versii:='001100000010110111';
                    when s.u=39 then kod_versii:='101010000110001011';
                    when s.u=40 then kod_versii:='111001000100010101';
                  end case;
                   
                   tmp:=0;
                    for kk in (quadro-11) .. (quadro-9) loop
                        for k in 0 .. 5 loop
                        draw:= regexp_replace(draw,'.',substr(kod_versii,tmp*6+(k+1),1), (quadro+1)*kk+1+k, 1);
                        end loop;
                        tmp:=tmp+1;
                    end loop;
                    
                    tmp:=0;
                    for kk in (quadro+1)-12 .. (quadro+1)-10 loop
                        for k in 0 .. 5 loop
                        draw:= regexp_replace(draw,'.',substr(kod_versii,tmp*6+(k+1),1), (quadro+1)*k+kk+1, 1);
                        end loop;
                        tmp:=tmp+1;
                    end loop;
              end if;    
              
              --код маски и уровня коррекции    
-- X ? столбец, Y ? строка, % ? остаток от деления, / ? целочисленное деление.              
--0    (X+Y) % 2
--1    Y % 2
--2    X % 3
--3    (X + Y) % 3
--4    (X/3 + Y/2) % 2
--5    (X*Y) % 2 + (X*Y) % 3
--6    ((X*Y) % 2 + (X*Y) % 3) % 2
--7    ((X*Y) % 3 + (X+Y) % 2) % 2
              kod_maski:=0;--3;
                 case   
                    when s.typ='l' and kod_maski=0 then kod_versii:='111011111000100'; 
                    when s.typ='l' and kod_maski=1 then kod_versii:='111001011110011';
                    when s.typ='l' and kod_maski=2 then kod_versii:='111110110101010';
                    when s.typ='l' and kod_maski=3 then kod_versii:='111100010011101';
                    when s.typ='l' and kod_maski=4 then kod_versii:='110011000101111';
                    when s.typ='l' and kod_maski=5 then kod_versii:='110001100011000';
                    when s.typ='l' and kod_maski=6 then kod_versii:='110110001000001';
                    when s.typ='l' and kod_maski=7 then kod_versii:='110100101110110';
                    
                    when s.typ='m' and kod_maski=0 then kod_versii:='101010000010010'; 
                    when s.typ='m' and kod_maski=1 then kod_versii:='101000100100101';
                    when s.typ='m' and kod_maski=2 then kod_versii:='101111001111100';
                    when s.typ='m' and kod_maski=3 then kod_versii:='101101101001011';
                    when s.typ='m' and kod_maski=4 then kod_versii:='100010111111001';
                    when s.typ='m' and kod_maski=5 then kod_versii:='100000011001110';
                    when s.typ='m' and kod_maski=6 then kod_versii:='100111110010111';
                    when s.typ='m' and kod_maski=7 then kod_versii:='100101010100000';
                    
                    when s.typ='q' and kod_maski=0 then kod_versii:='011010101011111'; 
                    when s.typ='q' and kod_maski=1 then kod_versii:='011000001101000';
                    when s.typ='q' and kod_maski=2 then kod_versii:='011111100110001';
                    when s.typ='q' and kod_maski=3 then kod_versii:='011101000000110';
                    when s.typ='q' and kod_maski=4 then kod_versii:='010010010110100';
                    when s.typ='q' and kod_maski=5 then kod_versii:='010000110000011';
                    when s.typ='q' and kod_maski=6 then kod_versii:='010111011011010';
                    when s.typ='q' and kod_maski=7 then kod_versii:='010101111101101';
                    
                    when s.typ='h' and kod_maski=0 then kod_versii:='001011010001001'; 
                    when s.typ='h' and kod_maski=1 then kod_versii:='001001110111110';
                    when s.typ='h' and kod_maski=2 then kod_versii:='001110011100111';
                    when s.typ='h' and kod_maski=3 then kod_versii:='001100111010000';
                    when s.typ='h' and kod_maski=4 then kod_versii:='000011101100010';
                    when s.typ='h' and kod_maski=5 then kod_versii:='000001001010101';
                    when s.typ='h' and kod_maski=6 then kod_versii:='000110100001100';
                    when s.typ='h' and kod_maski=7 then kod_versii:='000100000111011';
                  end case;      
            
            draw:= regexp_replace(draw,'.',substr(kod_versii,1,1),  (quadro+1)*(quadro-1)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,2,1),  (quadro+1)*(quadro-2)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,3,1),  (quadro+1)*(quadro-3)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,4,1),  (quadro+1)*(quadro-4)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,5,1),  (quadro+1)*(quadro-5)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,6,1),  (quadro+1)*(quadro-6)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,7,1),  (quadro+1)*(quadro-7)+1+8, 1);
            draw:= regexp_replace(draw,'.','1',  (quadro+1)*(quadro-8)+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,8,1),  (quadro+1)*8+1+(quadro-8), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,9,1),  (quadro+1)*8+1+(quadro-7), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,10,1),  (quadro+1)*8+1+(quadro-6), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,11,1),  (quadro+1)*8+1+(quadro-5), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,12,1),  (quadro+1)*8+1+(quadro-4), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,13,1),  (quadro+1)*8+1+(quadro-3), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,14,1),  (quadro+1)*8+1+(quadro-2), 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,15,1),  (quadro+1)*8+1+(quadro-1), 1); 
               
            draw:= regexp_replace(draw,'.',substr(kod_versii,1,1),  (quadro+1)*8+1, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,2,1),  (quadro+1)*8+1+1, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,3,1),  (quadro+1)*8+1+2, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,4,1),  (quadro+1)*8+1+3, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,5,1),  (quadro+1)*8+1+4, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,6,1),  (quadro+1)*8+1+5, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,7,1),  (quadro+1)*8+1+7, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,8,1),  (quadro+1)*8+1+8, 1);
            
            draw:= regexp_replace(draw,'.',substr(kod_versii,9,1),  (quadro+1)*7+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,10,1),  (quadro+1)*5+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,11,1),  (quadro+1)*4+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,12,1),  (quadro+1)*3+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,13,1),  (quadro+1)*2+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,14,1),  (quadro+1)*1+1+8, 1);
            draw:= regexp_replace(draw,'.',substr(kod_versii,15,1),  (quadro+1)*0+1+8, 1);    
            
            --рисую сами данные
            
            tmp:=1; --1-вверх 0-вниз
            s_s:=''; tmp1:=1;
            colonka:=1;--(quadro-1)/2;
            stroka:=1;
            flag:=1; 
            flag_lr:=0;--0-правая 1-левая
            WHILE tmp1<=length(tutto) 
            LOOP
               if flag=1 then
               s_s:=substr(tutto,tmp1,1);
               if s_s='0' then s_s:='2'; end if;
               if s_s='1' then s_s:='3'; end if;
               tmp1:=tmp1+1;
               flag:=0;
               end if;
               
               if tmp=1 and flag=0 then
                           
                            tmp_draw:=regexp_substr(draw,'.',(quadro+1)*(quadro-stroka)+1 +(quadro-colonka), 1);
                           
                            if tmp_draw='-' then
                            draw:= regexp_replace(draw,'.',trim(s_s), (quadro+1)*(quadro-stroka)+1 +(quadro-colonka), 1);
                            flag:=1;
                            else flag:=0;
                            end if;


                    if stroka=quadro and flag_lr=1 then tmp:=0; 
                         if colonka+2<>quadro-5 then colonka:=colonka+2; else colonka:=colonka+3; end if;
                         stroka:=stroka-1;  
                           
                    end if;
                    if flag_lr=1 then stroka:=stroka+1; end if; 
                    if flag_lr=0 then flag_lr:=1; colonka:=colonka+1; else flag_lr:=0; colonka:=colonka-1; end if;
                    
                    
               end if;
               
               if tmp=0 and flag=0 then
               
                            tmp_draw:=regexp_substr(draw,'.',(quadro+1)*(quadro-stroka)+1 +(quadro-colonka) , 1);
                            
                            if tmp_draw='-' then
                            draw:= regexp_replace(draw,'.',trim(s_s), (quadro+1)*(quadro-stroka)+1 +(quadro-colonka), 1);
                            flag:=1;
                            else flag:=0;
                            end if;

                           
                    if stroka=1 and flag_lr=1 then tmp:=1;  if colonka+2<>quadro-5 then colonka:=colonka+2; else colonka:=colonka+3; end if; 
                            stroka:=stroka+1;
                    
                    end if;
                    if flag_lr=1 then stroka:=stroka-1; end if;      
                    if flag_lr=0 then flag_lr:=1; colonka:=colonka+1; else flag_lr:=0; colonka:=colonka-1; end if;
                      
               end if;
            END LOOP;      
  
              --накладываю маску =0 - mod(stroka+colonka,2)
                     
              stroka:=0; colonka:=0;s_s:='';
              
              for i in 1..length(draw) loop
             
              stroka:=trunc(i/(quadro+1))+1-1; 
              colonka:=i-trunc(i/(quadro+1))*(quadro+1)-1;
              s_s:=substr(draw,i,1);
                  if s_s='2' or s_s='-'  then --это 0
                    if mod(stroka+colonka,2)=0 then
                    --if mod(colonka, 3)=0 then
                    --if mod(stroka, 2)=0 then
                    -- if mod(colonka+stroka, 3)=0 then
                    -- if mod(mod(colonka*stroka, 2)+mod(colonka*stroka,3),2)=0 then
                    draw:= regexp_replace(draw,'.','1', i, 1);
                    end if;
                  end if;
                  
                  if s_s='3' then --это 1
                    if mod(stroka+colonka,2)=0 then
                    --if mod(colonka, 3)=0 then
                    --if mod(colonka+stroka, 3)=0 then
                    --if mod(stroka, 2)=0 then
                    -- if mod(mod(colonka*stroka, 2)+mod(colonka*stroka,3),2)=0 then
                    draw:= regexp_replace(draw,'.','0', i, 1);
                    end if;
                  end if;
              end loop;
  end loop;

 --конверт в bmp
    dbms_lob.createtemporary(bmp_tmp, true);
    d:=0;
    if mod(ceil(quadro/8),4)<>0 then d:=4-mod(ceil(quadro/8),4); end if;
    strhex:= -- размер квадрата в пикселах, размер данных.. шапка bmp
    regexp_replace(
    regexp_replace(
    regexp_replace(
    regexp_replace(
    regexp_replace(
    regexp_replace(
    regexp_replace(
    regexp_replace(strhex,'..',substr(lpad(make_qr.dec2hex(quadro),4,'0'),1,2),39,1),
    '..', substr(lpad(make_qr.dec2hex(quadro),4,'0'),3,2),37,1),
    '..', substr(lpad(make_qr.dec2hex(quadro),4,'0'),1,2),47,1),
    '..', substr(lpad(make_qr.dec2hex(quadro),4,'0'),3,2),45,1),
    '..',substr(lpad(make_qr.dec2hex((ceil(quadro/8)/*+4*/+d)*quadro),4,'0'),1,2),71,1),
    '..',substr(lpad(make_qr.dec2hex((ceil(quadro/8)/*+4*/+d)*quadro),4,'0'),3,2),69,1),
    '..',substr(lpad(make_qr.dec2hex((ceil(quadro/8)/*+4*/+d)*quadro+62),4,'0'),1,2),7,1),
    '..',substr(lpad(make_qr.dec2hex((ceil(quadro/8)/*+4*/+d)*quadro+62),4,'0'),3,2),5,1);
 --   STD.DEBUG_MESSAGE('make_qr','strhex '||substr(strhex,1,1999)||' ');
  aaa:='';
  FOR i IN 0..61 LOOP
  aaa := aaa ||chr(to_number(substr(strhex,i*2+1,2),'XX'));
  END LOOP;
    
        draw:= replace(draw,'2','0');
        draw:= replace(draw,'3','1');
        draw:= replace(draw,'-','0');

       
        FOR i IN  1..quadro LOOP --reverse
            aaa_tmp := rpad(substr(draw,(quadro+1)*(quadro-i)+1 ,quadro),(ceil(quadro/8)/*+4*/+d)*8,'0'); --chr(to_number(substr(strhex,i*2+1,2),'XX'));
           p_t:='';
            for j in 1..quadro loop
                    if substr(aaa_tmp,j,1)='0' then aaa_tmp:=regexp_replace(aaa_tmp,'.','1',j,1);
                    else aaa_tmp:=regexp_replace(aaa_tmp,'.','0',j,1);
                    end if;
            end loop;

            for j in 0..(ceil(quadro/8)/*+4*/+d)-1 loop
            
            p_tmp:=substr(aaa_tmp,j*8+1,8);
            --dbms_lob.append(bmp_tmp, utl_raw.cast_to_raw( chr(to_number(dec2hex(bin2dec(p_tmp)),'XX')) ) );
            aaa:=aaa||chr(to_number(dec2hex(bin2dec(p_tmp)),'XX'));
            end loop;

        END LOOP;
      /* 
    for i in 1 .. trunc(length(aaa) / 2000) + 1 loop
      dbms_lob.append(bmp_tmp,
                      utl_raw.cast_to_raw(substr(aaa, 1, 2000)));
      aaa := substr(aaa, 2000);
    end loop;
    */
    dbms_lob.append(bmp_tmp, utl_raw.cast_to_raw(trim(aaa)));
    return bmp_tmp;
    dbms_lob.freetemporary(bmp_tmp);
    
 end;
--http://www.pvsm.ru/pesochnitsa/29255
end make_qr;
/
