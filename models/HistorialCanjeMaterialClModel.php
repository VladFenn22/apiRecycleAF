<?php
class HistorialCanjeMaterialClModel
{
    public $enlace;
    public function __construct()
    {
        $this->enlace = new MySqlConnect();
    }
    
    public function all()
    {
        try {
            
           
            $vSql = "SELECT hm.id,
            ca.nombre AS nombre_centro_acopio,
            cl.nombrecompleto AS nombre_cliente,
            hm.fecha_canje,
            m.nombre AS nombre_material,
            hm.cantidad
        FROM historialmaterial hm
        LEFT JOIN centroacopio ca ON hm.id_centro_acopio = ca.id
        LEFT JOIN usuario cl ON hm.id_cliente = cl.id
        LEFT JOIN material m ON hm.id_material = m.id
       ";
            
            //Ejecutar la consulta sql
            $vResultado = $this->enlace->executeSQL($vSql);
           
            //Retornar la respuesta
            return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
   
    public function get($id)
    {
        try {
            
            $vSql = "SELECT hm.id,
            ca.nombre AS nombre_centro_acopio,
            cl.nombrecompleto AS nombre_cliente,
            hm.fecha_canje,
            m.nombre AS nombre_material,
            hm.cantidad 
        FROM historialmaterial hm
        LEFT JOIN centroacopio ca ON hm.id_centro_acopio = ca.id
        LEFT JOIN usuario cl ON hm.id_cliente = cl.id
        LEFT JOIN material m ON hm.id_material = m.id  WHERE cl.id = $id";
            
            //Ejecutar la consulta sql
            $vResultado = $this->enlace->executeSQL($vSql);
           
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
            
			$sql = "Insert into historialmaterial (id_centro_acopio, id_cliente, fecha_canje, id_material, cantidad) Values ($objeto->id_centro_acopio,$objeto->id_cliente,'$objeto->fecha_canje',$objeto->id_material, $objeto->cantidad)";
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idHistorial = $this->enlace->executeSQL_DML_last( $sql);
            return $this->get($idHistorial);
          
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
   
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