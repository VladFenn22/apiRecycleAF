<?php
class MaterialModel
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
			$vSql = "select * from material;";
			
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
            $vSql = "select * from material where id = $id;";
            
            //Ejecutar la consulta sql
            $vResultado = $this->enlace->executeSQL($vSql);
            if(!empty($vResultado)){
                //Obtener objeto
                $vResultado = $vResultado[0];
            }
            //Retornar la respuesta
            return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
   
    public function getForm($id)
    {
        try {
            
     
            //Consulta sql
			$vSql = "SELECT * FROM material where id=$id";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
            $vResultado = $vResultado[0];
           
			// Retornar el objeto
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }

    
    public function getMaterialCentroAcopio($idCentroAcopio){
        try {
            //Consulta sql
			$vSql = "SELECT * 
            FROM material m,material_centro_acopio mca 
            where mca.idmaterial=m.id and mca.idcentroacopio=$idCentroAcopio";
			
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
            
			$sql = "Insert into material (nombre, descripcion, color, linkImagen, precio, unidad_medida)". 
                     "Values ('$objeto->nombre','$objeto->descripcion','$objeto->color','$objeto->linkImagen', $objeto->precio, '$objeto->unidad_medida')";
			
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idMaterial = $this->enlace->executeSQL_DML_last( $sql);
            //--- Generos ---
            //Crear elementos a insertar en generos
            foreach( $objeto->genres as $genre){
                $dataGenres[]=array($idMaterial,$genre);
            }
            /* $dataGenres=array(
                array(1,7),
                array(1,8)
                ); */
                
                foreach($dataGenres as $row){
                    
                    $valores=implode(',', $row);
                    $sql = "INSERT INTO Material_genre(Material_id,genre_id) VALUES(".$valores.");";
                    $vResultado = $this->enlace->executeSQL_DML($sql);
                }
            //--- Actores ---
            //Crear elementos a insertar en actores
            foreach ($objeto->actors as $row) {
                $sql = "INSERT INTO Material_cast(Material_id,actor_id,role) VALUES($idMaterial, $row->actor_id,'$row->role')";
                $vResultado = $this->enlace->executeSQL_DML($sql);
            } 
            //Retornar pelicula
            return $this->get($idMaterial);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
     /**
	 * Actualizar pelicula
	 * @param $objeto pelicula a actualizar
	 * @return $this->get($idMaterial) - Objeto pelicula
	 */
	//
    public function update($objeto) {
        try {
            //Consulta sql
            
			$sql = "Update material SET nombre ='$objeto->nombre',".
            "descripcion ='$objeto->descripcion',color ='$objeto->color',linkImagen ='$objeto->linkImagen',".
            "precio=$objeto->precio". 
            " Where id=$objeto->id";
			
            //Ejecutar la consulta
			$cResults = $this->enlace->executeSQL_DML( $sql);
          
            return $this->get($objeto->id);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }    
   
}