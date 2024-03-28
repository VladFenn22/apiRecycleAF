<?php
class CentroAcopioModel
{
    public $enlace;
    public function __construct()
    {
        $this->enlace = new MySqlConnect();
    }

    public function all()
    {
        try {
            //Consulta sql
			$vSql = "SELECT
            ca.id, 
            ca.nombre as Nombre_centro_acopio,
            p.provincia as Provincia,
            c.canton as Cantón,
            ca.direccion as Dirección,
            ca.telefono as Teléfono,
            ca.horario_atencion as Horario_atención,
            a.nombrecompleto AS Nombre,
            CASE 
                WHEN ca.estado = 1 THEN 'activo'
                WHEN ca.estado = 0 THEN 'inactivo'
            END AS Estado
        FROM centroacopio ca
        INNER JOIN provincia p ON ca.idProvincia = p.id
        INNER JOIN canton c ON ca.IdCanton = c.id
        LEFT JOIN usuario a ON ca.administrador_id = a.id
        ORDER BY ca.nombre ASC;";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
				
			// Retornar el objeto
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }

    public function get($id)
    {
        try {
          
            $materialModel = new MaterialModel();
            $vSql = "SELECT
            ca.nombre as Nombre_centro_acopio,
            p.provincia as Provincia,
            c.canton as Cantón,
            ca.direccion as Dirección,
            ca.telefono as Teléfono,
            ca.horario_atencion as Horario_atención,
            ca.administrador_id AS idAdministrador,
            a.nombrecompleto as Nombre,
            CASE 
                WHEN ca.estado = 1 THEN 'activo'
                WHEN ca.estado = 0 THEN 'inactivo'
            END AS Estado
        FROM centroacopio ca
        INNER JOIN provincia p ON ca.idProvincia = p.id
        INNER JOIN canton c ON ca.IdCanton = c.id
        LEFT JOIN usuario a ON ca.administrador_id = a.id where ca.id = $id";
            
            //Ejecutar la consulta sql
            $vResultado = $this->enlace->executeSQL($vSql);
            if(!empty($vResultado)){
                //Obtener objeto
            $vResultado = $vResultado[0];

            $listadoMateriales = $materialModel->getMaterialCentroAcopio($id);
            
            $vResultado->material = $listadoMateriales;

        
            }


            //Retornar la respuesta
            return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    } 
    /**
	 * Obtener pelicula para mostrar información en Formulario
	 * @param $id de la pelicula
	 * @return $vresultado - Objeto pelicula
	 */
	//
    public function getForm($id)
    {
        try {
            
            $materialM = new MaterialModel();
            //Consulta sql
			$vSql = "select * from centroacopio where id =$id";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
            $vResultado = $vResultado[0];

            $material=$materialM->getMaterialCentroAcopio($id);
            if(!empty($material)){
                $material = array_column($material,'id');
            }else{
                $material=[];
            }   

            $vResultado->material=$material;  

          
                
       
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
    public function getCountByMaterial($param){
        try {
			$vResultado =null;
            //Consulta sql
			$vSql = "SELECT mc.idmaterial, m.nombre as 'Nombre', m.descripcion as 'Descripción', m.color, m.linkImagen, m.cantidad as 'Cantidad', 
                        m.precio as 'Precio de la moneda', m.unidad_medida as 'Unidad de medida'
                        FROM material m, material_centro_acopio mc, centroacopio c
                        where mc.idcentroacopio=m.id and mc.idmaterial=m.id
                        group by mc.idmaterial";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
			// Retornar el objeto
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }

    public function create($objeto) {
        try {
            //Consulta sql
            //Identificador autoincrementable
            
			$sql = "Insert into centroacopio (nombre, idProvincia, IdCanton, direccion, telefono, horario_atencion, administrador_id, estado)". 
                     "Values ('$objeto->nombre',$objeto->idProvincia,$objeto->IdCanton,'$objeto->direccion', '$objeto->telefono', '$objeto->horario_atencion', $objeto->administrador_id, $objeto->estado )";
			
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idCentroAcopio = $this->enlace->executeSQL_DML_last( $sql);
  
            foreach( $objeto->materiales as $material){
                $dataMateriales[]=array($idCentroAcopio,$material);
            }
           
                
                foreach($dataMateriales as $row){
                    $valores=implode(',', $row);
                    $sql = "INSERT INTO material_centro_acopio(idcentroacopio,idmaterial) VALUES(".$valores.");";
                    $vResultado = $this->enlace->executeSQL_DML($sql);
                }

           
            //Retornar pelicula
            return $this->get($idCentroAcopio);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
     /**
	 * Actualizar pelicula
	 * @param $objeto pelicula a actualizar
	 * @return $this->get($idMovie) - Objeto pelicula
	 */
	//
    public function update($objeto) {
        try {
            //Consulta sql
            
			$sql = "Update centroacopio SET nombre ='$objeto->nombre',".
            "idProvincia ='$objeto->idProvincia',IdCanton ='$objeto->IdCanton',direccion ='$objeto->direccion', 
            telefono ='$objeto->telefono', horario_atencion='$objeto->horario_atencion', 
            administrador_id=$objeto->administrador_id, estado=$objeto->estado". 
            " Where id=$objeto->id";
			
            //Ejecutar la consulta
			$cResults = $this->enlace->executeSQL_DML( $sql);
            //--- Generos ---
            //Borrar Generos existentes asignados
            
			$sql = "Delete from material_centro_acopio Where idcentroacopio=$objeto->id";
			$cResults = $this->enlace->executeSQL_DML( $sql);

            
            foreach( $objeto->material as $material){
                $dataMateriales[]=array($objeto->id,$material);
            }
        
            foreach($dataMateriales as $row){
                
                $valores=implode(',', $row);
                $sql = "INSERT INTO material_centro_acopio(idcentroacopio,idmaterial) VALUES(".$valores.");";
                $vResultado = $this->enlace->executeSQL_DML($sql);
                
            }
            
            //Retornar pelicula
            return $this->get($objeto->id);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }    
   
}