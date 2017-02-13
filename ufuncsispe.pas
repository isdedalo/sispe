unit ufuncsispe;

interface

uses
  FireDAC.Comp.Client, system.StrUtils, Data.Win.ADODB, System.Classes,System.SysUtils,Vcl.Dialogs;


function fnAportaciones(ADOTable :TADOTable; nomarch,dependencia,desde,hasta  : String;fregistro : TDate): boolean;
function fnSqliteAclaraciones(sql  : String): boolean;

implementation

uses udmDatos;

{Funcion que ingresa las aportaciones a la base de datos sispe }
function fnAportaciones(ADOTable :TADOTable; nomarch,dependencia,desde,hasta  : String;fregistro : TDate): boolean;
var
  pgQry,pgQry2      : TFDQuery;
  rfc,nombre,proyecto,categoria,cuenta,curp,sexo:string;
  sueldo: Double;
  fnac: TDate;
  anio,mes,dia : Word;

begin
  pgQry        := TFDQuery.Create(nil);
  pgQry2       := TFDQuery.Create(nil);
  pgQry.Connection   := dmDatos.pgconeccion;
  pgQry2.Connection  := dmDatos.pgconeccion;
  pgQry.SQL.Clear;
  rfc := LeftStr(Trim(ADOTable.FieldByName('rfc').AsString),13);{Obtiene 13 caracteres del RFC del Aportador el campo en el archivo es de longitud 14 }
  pgQry.SQL.Add('select rfc from datos.empleados where rfc = '''+ rfc +'''');
  pgQry.Active := True;
  curp:= '';
  Result := True;
  if pgQry.RecordCount = 0 then{Si no se encontro el aportador en la tabla empleados se registran sus datos y se pone su status en pendiente}
  begin
    nombre := Trim(ADOTable.FieldByName('nombre').AsString);
    fnac := StrToDate(Copy(ADOTable.FieldByName('rfc').AsString,9,2)+'/'+Copy(ADOTable.FieldByName('rfc').AsString,7,2)+'/'+  Copy(ADOTable.FieldByName('rfc').AsString,5,2));
    if fnac > Now then
    begin
      DecodeDate(fnac,anio,mes,dia);
      anio:=anio-100;
      fnac:=EncodeDate(anio,mes,dia);
    end;
    proyecto   := Trim(ADOTable.FieldByName('proyecto').AsString);
    categoria  := Trim(ADOTable.FieldByName('categoria').AsString);
    sueldo     := ADOTable.FieldByName('sueldo').AsFloat;
    {Preguntamos si el archivo es centralizado o descentralizado para obtener el sexo o la curp dependiendo del tipo de archivo
    se agrega a la tabla de empleados}
    {se agrega la información a la tabla de empleados y aportaciones }
   if Ansipos(trim('SECTOR CENTRAL'),trim(dependencia))<>0 then
     sexo := '';
    pgQry2.SQL.Clear;
    pgQry2.SQL.Add('insert into datos.empleados(rfc,nombre_em,sexo,fecha_nac, proyecto, cve_categ, sueldo_base,pendiente,curp) ');
    pgQry2.SQL.Add('values('+chr(39)+rfc+chr(39)+','+chr(39)+nombre+chr(39)+','+chr(39)+sexo+chr(39)+','+chr(39)+DateToStr(fnac)+chr(39)+','+chr(39)+ proyecto+chr(39)+','+chr(39)+categoria+chr(39)+','+FloatToStr(sueldo)+',true,'+chr(39)+curp+chr(39)+')');
    try
      pgQry2.ExecSQL;
    except on E: Exception do   //Lo hace por cada insert hacer la validacion al archivo para sacarlo antes
    begin
      ShowMessage('Ocurrio un error verifique los registros del archivo: '+nomarch);
      Result := False;
    end;
    end;
  end;
  {se agrega la información a la tabla de aportaciones }
  pgQry2.SQL.Clear;
  pgQry2.SQL.Add('insert into datos.aportaciones(rfc,inicio,final,new_tipo,movimiento,entrada,cuenta,fecharegistro,curp,archivo)');
  pgQry2.SQL.Add('values('+chr(39)+rfc+chr(39)+','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+'A'+ADOTable.FieldByName('tipoaporta').AsString+chr(39)+','+chr(39)+'APORTACION'+chr(39)+','+FloatToStr(ADOTable.FieldByName('aportacion').AsFloat)+','+chr(39)+cuenta+chr(39)+','+chr(39)+DateToStr(fregistro)+chr(39)+','+chr(39)+curp+chr(39)+','+chr(39)+nomarch+chr(39)+')');
  try
    pgQry2.ExecSQL;
    Result := True;
  except on E: Exception do
  begin
    ShowMessage('values('+chr(39)+rfc+chr(39)+','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+'A'+ADOTable.FieldByName('tipoaporta').AsString+chr(39)+','+chr(39)+'APORTACION'+chr(39)+','+FloatToStr(ADOTable.FieldByName('aportacion').AsFloat)+','+chr(39)+cuenta+chr(39)+','+chr(39)+DateToStr(fregistro)+chr(39)+','+chr(39)+curp+chr(39)+','+chr(39)+nomarch+chr(39)+')');
    ShowMessage('Ocurrio un error verifique los registros del archivo: '+nomarch);
  end;
  end;
  pgQry.Close;
  pgQry2.Close;
  pgQry.Free;;
  pgQry2.Free;;
end;
{Función que vacia empleados de la base de datos de PG sispe a la base de datos SqlLite aclaraciones}
function fnSqliteAclaraciones(sql  : String): boolean;
var
  qrySqlLite : TFDQuery;
  nombre,rfc : String;
  idpemplea  : Integer;

begin
  qrySqlLite := TFDQuery.Create(nil);
  qrySqlLite.Connection := dmDatos.coneccionSqlLite;
  qrySqlLite.SQL.Clear;
  qrySqlLite.SQL.Add('UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='+chr(39)+'aclaraciones'+chr(39));
  qrySqlLite.ExecSQL;
  qrySqlLite.SQL.Clear;
  qrySqlLite.SQL.Add('delete from aclaraciones');
  qrySqlLite.ExecSQL;
  qrySqlLite.SQL.Clear;
  dmDatos.qry.Active := False;
  dmDatos.qry.SQL.Clear;
  dmDatos.qry.SQL.Add(sql);
  dmDatos.qry.Active := True;
  While not dmDatos.qry.Eof do
  begin
    qrySqlLite.SQL.Clear;
    rfc    := dmDatos.qry.FieldByName('rfc').AsString;
    nombre := dmDatos.qry.FieldByName('nombre_em').AsString;
    idpemplea := dmDatos.qry.FieldByName('id').AsInteger;
    qrySqlLite.SQL.Add('insert into aclaraciones(rfc,nombre,idpemplea) values('+chr(39)+rfc+chr(39)+','+chr(39)+nombre+chr(39)+','+IntToStr(idpemplea)+');');
    qrySqlLite.ExecSQL;
    dmDatos.qry.Next;
  end;
  dmDatos.qry.Active := False;
  dmDatos.QrySqlLite.Active := False;
  dmDatos.QrySqlLite.SQL.Clear;
  QrySqlLite.Free;
  Result := True;
end;

end.
