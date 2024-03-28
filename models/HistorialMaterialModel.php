<?php
class HistorialMaterialModel
{
    public $enlace;
    public function __construct()
    {
        $this->enlace = new MySqlConnect();
    }
    /**
	 * Listar historial material 
	 * @param 
	 * @return $vresultado - Lista de objectos
	 */
	//
    public function all()
    {
        try {
            //Consulta sql
			$vSql = "SELECT * FROM historial_material order by title asc;";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
				
			// Retornar el objeto
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
    /**
	 * Obtener una pelicula
	 * @param $id de la pelicula
	 * @return $vresultado - Objeto pelicula
	 */
	//
    public function get($id)
    {
        try {
            $MaterialModel = new MaterialModel();
            $UsuarioModel = new UsuarioModel();
            $CentroAcopioModel=new CentroAcopioModel();
            $vSql = "SELECT * from movie where id = $id";
            
            //Ejecutar la consulta sql
            $vResultado = $this->enlace->executeSQL($vSql);
            if(!empty($vResultado)){
                //Obtener objeto
                $vResultado = $vResultado[0];

                //---Director
                $usuario = $UsuarioModel->get($vResultado->id_cliente);
                //Asignar director al objeto  
                $vResultado->usuario = $usuario[0]; 

                //---Generos 
                $Materiales = $MaterialModel->get($vResultado->id_material);
                //Asignar generos al objeto
                $vResultado->material = $Materiales[0];
                
                //---Actores
                $CentroAcopio= $CentroAcopioModel->get($vResultado->id_centro_acopio);
                //Asignar actores al objeto  
                $vResultado->centroacopio = $CentroAcopio[0]; 
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
            

            //Consulta sql
			$vSql = "SELECT * FROM historial_material where id=$id";
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
            $vResultado = $vResultado[0];
         
           
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
            
			$sql = "Insert into historial_material (id_centro_acopio, id_cliente, fecha_canje, id_material, cantidad)". 
                     "Values ($objeto->id_centro_acopio,$objeto->id_cliente,'$objeto->fecha_canje',$objeto->id_material, $objeto->cantidad)";
			
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idMovie = $this->enlace->executeSQL_DML_last( $sql);
          
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
            
			$sql = "Update historial_material SET id_centro_acopio =$objeto->id_centro_acopio,".
            "id_cliente =$objeto->id_cliente, fecha_canje ='$objeto->fecha_canje',id_material =$objeto->id_material,".
            "cantidad=$objeto->cantidad". 
            " Where id=$objeto->id";
			
            //Ejecutar la consulta
			$cResults = $this->enlace->executeSQL_DML( $sql);
          
            //Retornar pelicula
            return $this->get($objeto->id);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }    
   
}