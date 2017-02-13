object dmDatos: TdmDatos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 540
  Width = 777
  object pgconeccion: TFDConnection
    Params.Strings = (
      'Database=sispe'
      'User_Name=postgres'
      'Password=admindie'
      'ApplicationName=SISPE'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 269
    Top = 96
  end
  object qryUsuarios: TFDQuery
    BeforeInsert = qryUsuariosBeforeInsert
    AfterInsert = qryUsuariosAfterInsert
    BeforeEdit = qryUsuariosBeforeEdit
    AfterEdit = qryUsuariosAfterEdit
    BeforePost = qryUsuariosBeforePost
    AfterPost = qryUsuariosAfterPost
    AfterCancel = qryUsuariosAfterCancel
    BeforeDelete = qryUsuariosBeforeDelete
    BeforeScroll = qryUsuariosBeforeScroll
    AfterScroll = qryUsuariosAfterScroll
    Connection = pgconeccion
    UpdateObject = pgupdate
    SQL.Strings = (
      'select * from catalogos.usuarios order by idusuario')
    Left = 544
    Top = 16
    object qryUsuariosidusuario: TIntegerField
      FieldName = 'idusuario'
      Origin = 'idusuario'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryUsuariosusuario: TWideStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      FixedChar = True
    end
    object qryUsuariospassword: TWideStringField
      FieldName = 'password'
      Origin = '"password"'
      FixedChar = True
      Size = 50
    end
    object qryUsuariosnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      FixedChar = True
      Size = 150
    end
    object qryUsuariospuesto: TWideStringField
      FieldName = 'puesto'
      Origin = 'puesto'
      FixedChar = True
      Size = 50
    end
    object qryUsuariosobservaciones: TWideStringField
      FieldName = 'observaciones'
      Origin = 'observaciones'
      FixedChar = True
      Size = 250
    end
    object qryUsuariosfregistro: TDateField
      FieldName = 'fregistro'
      Origin = 'fregistro'
    end
    object qryUsuariosfuacceso: TDateField
      FieldName = 'fuacceso'
      Origin = 'fuacceso'
    end
    object qryUsuariosactivo: TBooleanField
      FieldName = 'activo'
      Origin = 'activo'
    end
    object qryUsuariosmenuacceso: TWideStringField
      FieldName = 'menuacceso'
      Origin = 'menuacceso'
      FixedChar = True
      Size = 255
    end
    object qryUsuarioscveent: TWideStringField
      FieldName = 'cveent'
      Origin = 'cveent'
      FixedChar = True
      Size = 2
    end
    object qryUsuarioscvedtofe: TWideStringField
      FieldName = 'cvedtofe'
      Origin = 'cvedtofe'
      FixedChar = True
      Size = 2
    end
    object qryUsuarioscvemod: TWideStringField
      FieldName = 'cvemod'
      Origin = 'cvemod'
      FixedChar = True
      Size = 6
    end
    object qryUsuarioscvereg: TWideStringField
      FieldName = 'cvereg'
      Origin = 'cvereg'
      FixedChar = True
      Size = 2
    end
    object qryUsuarioscvedto: TWideStringField
      FieldName = 'cvedto'
      Origin = 'cvedto'
      FixedChar = True
      Size = 2
    end
    object qryUsuarioscvemun: TWideStringField
      FieldName = 'cvemun'
      Origin = 'cvemun'
      FixedChar = True
      Size = 3
    end
    object qryUsuarioscveloc: TWideStringField
      FieldName = 'cveloc'
      Origin = 'cveloc'
      FixedChar = True
      Size = 4
    end
    object qryUsuarioscvenivel: TWideStringField
      FieldName = 'cvenivel'
      Origin = 'cvenivel'
      FixedChar = True
      Size = 1
    end
    object qryUsuarioscvesecretaria: TSmallintField
      FieldName = 'cvesecretaria'
      Origin = 'cvesecretaria'
    end
    object qryUsuarioscvedireccion: TSmallintField
      FieldName = 'cvedireccion'
      Origin = 'cvedireccion'
    end
    object qryUsuarioscvedepartamento: TSmallintField
      FieldName = 'cvedepartamento'
      Origin = 'cvedepartamento'
    end
  end
  object pgupdate: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO catalogos.usuarios'
      '(usuario, "password", nombre, puesto, observaciones, '
      '  fregistro, fuacceso, activo, menuacceso, '
      '  cveent, cvedtofe, cvemod, cvereg, cvedto, '
      '  cvemun, cveloc, cvenivel, cvesecretaria, '
      '  cvedireccion, cvedepartamento)'
      
        'VALUES (:new_usuario, :new_password, :new_nombre, :new_puesto, :' +
        'new_observaciones, '
      '  :new_fregistro, :new_fuacceso, :new_activo, :new_menuacceso, '
      
        '  :new_cveent, :new_cvedtofe, :new_cvemod, :new_cvereg, :new_cve' +
        'dto, '
      '  :new_cvemun, :new_cveloc, :new_cvenivel, :new_cvesecretaria, '
      '  :new_cvedireccion, :new_cvedepartamento)'
      
        'RETURNING idusuario, usuario, "password", nombre, puesto, observ' +
        'aciones, fregistro, fuacceso, activo, menuacceso, cveent, cvedto' +
        'fe, cvemod, cvereg, cvedto, cvemun, cveloc, cvenivel, cvesecreta' +
        'ria, cvedireccion, cvedepartamento')
    ModifySQL.Strings = (
      'UPDATE catalogos.usuarios'
      
        'SET usuario = :new_usuario, "password" = :new_password, nombre =' +
        ' :new_nombre, '
      '  puesto = :new_puesto, observaciones = :new_observaciones, '
      
        '  fregistro = :new_fregistro, fuacceso = :new_fuacceso, activo =' +
        ' :new_activo, '
      
        '  menuacceso = :new_menuacceso, cveent = :new_cveent, cvedtofe =' +
        ' :new_cvedtofe, '
      
        '  cvemod = :new_cvemod, cvereg = :new_cvereg, cvedto = :new_cved' +
        'to, '
      
        '  cvemun = :new_cvemun, cveloc = :new_cveloc, cvenivel = :new_cv' +
        'enivel, '
      
        '  cvesecretaria = :new_cvesecretaria, cvedireccion = :new_cvedir' +
        'eccion, '
      '  cvedepartamento = :new_cvedepartamento'
      'WHERE idusuario = :old_idusuario'
      
        'RETURNING idusuario, usuario, "password", nombre, puesto, observ' +
        'aciones, fregistro, fuacceso, activo, menuacceso, cveent, cvedto' +
        'fe, cvemod, cvereg, cvedto, cvemun, cveloc, cvenivel, cvesecreta' +
        'ria, cvedireccion, cvedepartamento')
    DeleteSQL.Strings = (
      'DELETE FROM catalogos.usuarios'
      'WHERE idusuario = :old_idusuario')
    FetchRowSQL.Strings = (
      
        'SELECT idusuario, usuario, "password" AS "password", nombre, pue' +
        'sto, '
      '  observaciones, fregistro, fuacceso, activo, menuacceso, '
      '  cveent, cvedtofe, cvemod, cvereg, cvedto, cvemun, cveloc, '
      '  cvenivel, cvesecretaria, cvedireccion, cvedepartamento'
      'FROM catalogos.usuarios'
      'WHERE idusuario = :idusuario')
    Left = 624
    Top = 16
  end
  object dsUsuarios: TDataSource
    AutoEdit = False
    DataSet = qryUsuarios
    Left = 704
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 440
    Top = 96
  end
  object qryOpciones: TFDQuery
    MasterSource = dsUsuarios
    MasterFields = 'idusuario'
    Connection = pgconeccion
    UpdateObject = updqryOpciones
    SQL.Strings = (
      'select * from catalogos.opciones order by idopcion')
    Left = 544
    Top = 80
  end
  object updqryOpciones: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO catalogos.opciones'
      '(idusuario, idopcion, etiqueta, habilitar, '
      '  ocultar, formulario, checked)'
      
        'VALUES (:new_idusuario, :new_idopcion, :new_etiqueta, :new_habil' +
        'itar, '
      '  :new_ocultar, :new_formulario, :new_checked)'
      
        'RETURNING id, idusuario, idopcion, etiqueta, habilitar, ocultar,' +
        ' formulario, checked')
    ModifySQL.Strings = (
      'UPDATE catalogos.opciones'
      
        'SET idusuario = :new_idusuario, idopcion = :new_idopcion, etique' +
        'ta = :new_etiqueta, '
      
        '  habilitar = :new_habilitar, ocultar = :new_ocultar, formulario' +
        ' = :new_formulario, '
      '  checked = :new_checked'
      
        'WHERE id = :old_id AND idusuario = :old_idusuario AND idopcion =' +
        ' :old_idopcion'
      
        'RETURNING id, idusuario, idopcion, etiqueta, habilitar, ocultar,' +
        ' formulario, checked')
    DeleteSQL.Strings = (
      'DELETE FROM catalogos.opciones'
      
        'WHERE id = :old_id AND idusuario = :old_idusuario AND idopcion =' +
        ' :old_idopcion')
    FetchRowSQL.Strings = (
      
        'SELECT id, idusuario, idopcion, etiqueta, habilitar, ocultar, fo' +
        'rmulario, '
      '  checked'
      'FROM catalogos.opciones'
      
        'WHERE id = :id AND idusuario = :idusuario AND idopcion = :idopci' +
        'on')
    Left = 624
    Top = 80
  end
  object dsOpciones: TDataSource
    DataSet = qryOpciones
    Left = 704
    Top = 80
  end
  object qryDeptos: TFDQuery
    MasterSource = dsDirecciones
    MasterFields = 'cvedireccion;cvesecretaria'
    Connection = pgconeccion
    UpdateObject = updDeptos
    SQL.Strings = (
      
        'select * from catalogos.departamentos where cvesecretaria = :cve' +
        'secretaria and cvedireccion = :cvedireccion order by cvesecretar' +
        'ia,cvedireccion,cvedepartamento')
    Left = 544
    Top = 264
    ParamData = <
      item
        Name = 'CVESECRETARIA'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'CVEDIRECCION'
        DataType = ftSmallint
        ParamType = ptInput
      end>
  end
  object updDeptos: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO catalogos.catdepartamentos'
      '(cvesecretaria, cvedireccion, descripcion, titular, '
      '  docfacturas)'
      
        'VALUES (:new_cvesecretaria, :new_cvedireccion, :new_descripcion,' +
        ' :new_titular, '
      '  :new_docfacturas)'
      
        'RETURNING cvesecretaria, cvedireccion, cvedepartamento, descripc' +
        'ion, titular, docfacturas')
    ModifySQL.Strings = (
      'UPDATE catalogos.catdepartamentos'
      
        'SET cvesecretaria = :new_cvesecretaria, cvedireccion = :new_cved' +
        'ireccion, '
      '  descripcion = :new_descripcion, titular = :new_titular, '
      '  docfacturas = :new_docfacturas'
      
        'WHERE cvesecretaria = :old_cvesecretaria AND cvedireccion = :old' +
        '_cvedireccion AND '
      '  cvedepartamento = :old_cvedepartamento'
      
        'RETURNING cvesecretaria, cvedireccion, cvedepartamento, descripc' +
        'ion, titular, docfacturas')
    DeleteSQL.Strings = (
      'DELETE FROM catalogos.catdepartamentos'
      
        'WHERE cvesecretaria = :old_cvesecretaria AND cvedireccion = :old' +
        '_cvedireccion AND '
      '  cvedepartamento = :old_cvedepartamento')
    FetchRowSQL.Strings = (
      
        'SELECT cvesecretaria, cvedireccion, cvedepartamento, descripcion' +
        ', titular, '
      '  docfacturas'
      'FROM catalogos.catdepartamentos'
      
        'WHERE cvesecretaria = :cvesecretaria AND cvedireccion = :cvedire' +
        'ccion AND '
      '  cvedepartamento = :cvedepartamento')
    Left = 624
    Top = 264
  end
  object dsDeptos: TDataSource
    AutoEdit = False
    DataSet = qryDeptos
    Left = 704
    Top = 264
  end
  object qrySecretarias: TFDQuery
    MasterSource = dsUsuarios
    MasterFields = 'idusuario'
    Connection = pgconeccion
    UpdateObject = updSecretarias
    SQL.Strings = (
      'select * from  catalogos.secretarias order by cvesecretaria')
    Left = 544
    Top = 152
  end
  object updSecretarias: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO catalogos.catsecretarias'
      '(descripcion)'
      'VALUES (:new_descripcion)'
      'RETURNING cvesecretaria, descripcion')
    ModifySQL.Strings = (
      'UPDATE catalogos.catsecretarias'
      'SET descripcion = :new_descripcion'
      'WHERE cvesecretaria = :old_cvesecretaria'
      'RETURNING cvesecretaria, descripcion')
    DeleteSQL.Strings = (
      'DELETE FROM catalogos.catsecretarias'
      'WHERE cvesecretaria = :old_cvesecretaria')
    FetchRowSQL.Strings = (
      'SELECT cvesecretaria, descripcion'
      'FROM catalogos.catsecretarias'
      'WHERE cvesecretaria = :cvesecretaria')
    Left = 624
    Top = 152
  end
  object dsSecretarias: TDataSource
    AutoEdit = False
    DataSet = qrySecretarias
    Left = 704
    Top = 152
  end
  object qryDirecciones: TFDQuery
    MasterSource = dsSecretarias
    MasterFields = 'cvesecretaria'
    DetailFields = 'cvesecretaria'
    Connection = pgconeccion
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateObject = updDirecciones
    SQL.Strings = (
      
        'select * from  catalogos.direcciones where cvesecretaria= :cvese' +
        'cretaria order by cvesecretaria,cvedireccion')
    Left = 544
    Top = 208
    ParamData = <
      item
        Name = 'CVESECRETARIA'
        DataType = ftLargeint
        ParamType = ptInput
        Size = 8
      end>
  end
  object updDirecciones: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO catalogos.catdirecciones'
      '(cvesecretaria, descripcion)'
      'VALUES (:new_cvesecretaria, :new_descripcion)'
      'RETURNING cvedireccion, cvesecretaria, descripcion')
    ModifySQL.Strings = (
      'UPDATE catalogos.catdirecciones'
      
        'SET cvesecretaria = :new_cvesecretaria, descripcion = :new_descr' +
        'ipcion'
      'WHERE cvedireccion = :old_cvedireccion'
      'RETURNING cvedireccion, cvesecretaria, descripcion')
    DeleteSQL.Strings = (
      'DELETE FROM catalogos.catdirecciones'
      'WHERE cvedireccion = :old_cvedireccion')
    FetchRowSQL.Strings = (
      'SELECT cvedireccion, cvesecretaria, descripcion'
      'FROM catalogos.catdirecciones'
      'WHERE cvedireccion = :cvedireccion')
    Left = 624
    Top = 208
  end
  object dsDirecciones: TDataSource
    AutoEdit = False
    DataSet = qryDirecciones
    Left = 704
    Top = 208
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    DriverID = 'PG'
    VendorHome = 'C:\Users\x3&u&\Documents\PENSIONES\SISTEMAS\SISPE'
    Left = 344
    Top = 96
  end
  object ADOConeccion: TADOConnection
    ConnectionString = 
      'Provider=VFPOLEDB.1;Data Source=D:\usuarios\jesus\PENSIONES\SIST' +
      'EMAS\SISPE\DBFs;Collating Sequence=MACHINE;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'VFPOLEDB.1'
    Left = 269
    Top = 208
  end
  object ADOQry: TADOQuery
    Connection = ADOConeccion
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SET CENTURY TO 19 ROLLOVER 10;'
      'SELECT * FROM acmm1605;')
    Left = 24
    Top = 152
  end
  object Qry: TFDQuery
    AutoCalcFields = False
    AfterPost = QryAfterPost
    BeforeDelete = QryBeforeDelete
    AfterScroll = QryAfterScroll
    Connection = pgconeccion
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockWait, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.KeyFields = 'id'
    OnError = QryError
    SQL.Strings = (
      'select id,rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,'
      
        'fecha_ing,depe,proyecto,cve_categ,sueldo_base,tipo_rel from dato' +
        's.p_emplea order by id limit 100')
    Left = 24
    Top = 16
  end
  object fdUpdqry: TFDUpdateSQL
    Connection = pgconeccion
    InsertSQL.Strings = (
      'INSERT INTO datos.p_emplea'
      '(rfc, nombre_em, sexo, fecha_nac, direccion, '
      '  proyecto, fecha_ing, cve_categ, sueldo_base, '
      '  tipo_rel, depe, status, nap)'
      
        'VALUES (:new_rfc, :new_nombre_em, :new_sexo, :new_fecha_nac, :ne' +
        'w_direccion, '
      
        '  :new_proyecto, :new_fecha_ing, :new_cve_categ, :new_sueldo_bas' +
        'e, '
      '  :new_tipo_rel, :new_depe, :new_status, :new_nap)'
      
        'RETURNING rfc, nombre_em, sexo, fecha_nac, direccion, proyecto, ' +
        'fecha_ing, cve_categ, sueldo_base, tipo_rel, depe, status, nap, ' +
        'id')
    ModifySQL.Strings = (
      'UPDATE datos.p_emplea'
      
        'SET rfc = :new_rfc, nombre_em = :new_nombre_em, sexo = :new_sexo' +
        ', '
      '  fecha_nac = :new_fecha_nac, direccion = :new_direccion, '
      
        '  proyecto = :new_proyecto, fecha_ing = :new_fecha_ing, cve_cate' +
        'g = :new_cve_categ, '
      '  sueldo_base = :new_sueldo_base, tipo_rel = :new_tipo_rel, '
      '  depe = :new_depe, status = :new_status, nap = :new_nap'
      'WHERE id = :old_id'
      
        'RETURNING rfc, nombre_em, sexo, fecha_nac, direccion, proyecto, ' +
        'fecha_ing, cve_categ, sueldo_base, tipo_rel, depe, status, nap, ' +
        'id')
    DeleteSQL.Strings = (
      'DELETE FROM datos.p_emplea'
      'WHERE id = :old_id')
    FetchRowSQL.Strings = (
      
        'SELECT rfc, nombre_em, sexo, fecha_nac, direccion, proyecto, fec' +
        'ha_ing, '
      '  cve_categ, sueldo_base, tipo_rel, depe, status, nap, uuqm, '
      '  fum, hum, rpe, antig_q, unif, nue, id'
      'FROM datos.p_emplea'
      'WHERE id = :id')
    Left = 160
    Top = 16
  end
  object dsQry: TDataSource
    AutoEdit = False
    DataSet = Qry
    Left = 88
    Top = 16
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    VendorHome = 
      'D:\usuarios\jesus\PENSIONES\SISTEMAS\SISPE\bin\sqllite\sqlite-dl' +
      'l-win64-x64-3130000'
    Left = 344
    Top = 153
  end
  object coneccionSqlLite: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\x3&u&\Documents\PENSIONES\SISTEMAS\SISPE\DB\si' +
        'spe.db'
      'DriverID=SQLite')
    Left = 269
    Top = 153
  end
  object QrySqlLite: TFDQuery
    Connection = coneccionSqlLite
    SQL.Strings = (
      'select * from aclaraciones')
    Left = 24
    Top = 80
  end
  object dsSqlLite: TDataSource
    DataSet = QrySqlLite
    Left = 88
    Top = 80
  end
  object dsADOQry: TDataSource
    DataSet = ADOTable
    Left = 88
    Top = 152
  end
  object ADOTable: TADOTable
    ConnectionString = 
      'Provider=VFPOLEDB.1;Data Source=D:\USUARIOS\JESUS\PENSIONES\SIST' +
      'EMAS\SISPE\DBFS;Password="";Collating Sequence=MACHINE'
    CursorType = ctStatic
    TableName = 'dmms1607'
    Left = 264
    Top = 264
  end
  object qryReportes: TFDQuery
    MasterSource = dsDirecciones
    MasterFields = 'cvedireccion;cvesecretaria'
    Connection = pgconeccion
    SQL.Strings = (
      'select (total/sueldo) * 100 as porcen,* from historial.archivos')
    Left = 544
    Top = 336
  end
  object dsRteTotales: TDataSource
    AutoEdit = False
    DataSet = qryReportes
    Left = 608
    Top = 336
  end
end
