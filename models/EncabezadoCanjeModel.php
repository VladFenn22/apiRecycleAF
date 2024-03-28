<?php
class EncabezadoCanjeModel
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
			$vSql = "SELECT * FROM encabezado_canje order by id_centro_acopio asc;";
			
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
            

            $detalleCanje = new DetalleCanjeModel();
           //Consulta sql
           $vSql = "SELECT 
           ec.id,
           ca.nombre as nombre_centro_acopio,
           u_admin.nombrecompleto AS nombre_administrador,
           u_cliente.nombrecompleto AS nombre_cliente,
           ec.fecha_canje,
           (SELECT SUM(sub_total_monedas) FROM detalle_canje WHERE idEncabezado = ec.id) as Total_monedas
       FROM encabezado_canje AS ec
       LEFT JOIN centroacopio AS ca ON ec.id_centro_acopio = ca.id
       LEFT JOIN usuario AS u_admin ON ec.id_administrador = u_admin.id
       LEFT JOIN usuario AS u_cliente ON ec.id_cliente = u_cliente.id
       WHERE ec.id = $id;";
           

           //Ejecutar la consulta
           $vResultado = $this->enlace->ExecuteSQL ( $vSql);
           $vResultado = $vResultado[0];

           $detalles=$detalleCanje->get($id);
             
       
           $vResultado->detalles=$detalles;
         
      
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
            

             $detalleCanje = new DetalleCanjeModel();
            //Consulta sql
			$vSql = "SELECT 
           ec.id, ca.nombre as nombre_centro_acopio,
            u_admin.nombrecompleto AS nombre_administrador,
            u_cliente.nombrecompleto AS nombre_cliente,
            ec.fecha_canje
        FROM encabezado_canje AS ec
        LEFT JOIN centroacopio AS ca ON ec.id_centro_acopio = ca.id
        LEFT JOIN usuario AS u_admin ON ec.id_administrador = u_admin.id
        LEFT JOIN usuario AS u_cliente ON ec.id_cliente = u_cliente.id
        WHERE ec.id = $id;";
			

            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
            $vResultado = $vResultado[0];

            $detalles=$detalleCanje->getDetalleByEncabezado($id);

            $vResultado->detalles=$detalles;
          
       
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
    

    public function create($objeto) {
        try {
            //Consulta sql
            //Identificador autoincrementable
            
			$sql = "Insert into encabezado_canje (id_centro_acopio, id_cliente, id_administrador, fecha_canje, total)". 
                     "Values ($objeto->id,$objeto->id_cliente, $objeto->id_administrador,'$objeto->fecha_canje', $objeto->total )";
			
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idEcabezadoCanje = $this->enlace->executeSQL_DML_last( $sql);

           
            //Retornar pelicula
            return $this->get($idEcabezadoCanje);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
 
   
}