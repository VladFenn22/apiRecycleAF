<?php
class DetalleCanjeModel
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
			$vSql = "SELECT * FROM detalle_canje order by nombre asc;";
			
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
			$vResultado =null;
            //Consulta sql
			$vSql = "SELECT
            dc.idDetalle as Detalle,
            m.nombre as Material,
            FORMAT(dc.cantidad, 'N2') as Cantidad,
            FORMAT(m.precio, 'N2') as Precio,
            FORMAT(dc.sub_Total_monedas, 'N2') as sub_total_monedas,
            m.color
        FROM
            detalle_canje dc
        INNER JOIN
            encabezado_canje ec ON dc.idEncabezado = ec.id
        INNER JOIN
            material m ON dc.id_material = m.id
        WHERE
            ec.id =$id" ;
			
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
			// Retornar el objeto
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
            

            $materialModel = new MaterialModel();
            //Consulta sql
			$vSql = "SELECT * FROM detalle_canje where id_encabezado=$id";
			if(!empty($vResultado)){
                //Obtener objeto
                $vResultado = $vResultado[0];

            $material = $materialModel->get($vResultado->id_material);

            $vResultado->material = $material[0];
            }
            //Ejecutar la consulta
			$vResultado = $this->enlace->ExecuteSQL ( $vSql);
            $vResultado = $vResultado[0];
            
          
       
			return $vResultado;
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }
    public function getDetalleByEncabezado($id){
        try {
			$vResultado =null;
            //Consulta sql
			$vSql = "SELECT dc.idDetalle as Detalle, m.nombre as Material, dc.sub_total_monedas,
            (SELECT SUM(dc2.sub_total_monedas) 
             FROM detalle_canje dc2
             INNER JOIN encabezado_canje ec2 ON dc2.idEncabezado = ec2.id
             WHERE ec2.id = 1) as Total_monedas
     FROM detalle_canje dc
     INNER JOIN encabezado_canje ec ON dc.idEncabezado = ec.id
     INNER JOIN material m ON dc.id_material = m.id
     WHERE ec.id = $id";
			
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
            
			$sql = "Insert into detalle_canje (IdEncabezado, id_material, cantidad, sub_total_monedas)". 
                     "Values ($objeto->idEncabezado,$objeto->id_material, $objeto->cantidad, $objeto->sub_total_monedas)";
			
            //Ejecutar la consulta
            //Obtener ultimo insert
			$idDetalleCanje = $this->enlace->executeSQL_DML_last( $sql);

            return $this->get($idDetalleCanje);
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
            
			$sql = "Update detalle_canje SET nombre ='$objeto->nombre',".
            "provincia ='$objeto->provincia',canton ='$objeto->canton',direccion ='$objeto->direccion', 
            telefono ='$objeto->telefono', horario_atencion='$objeto->horario_atencion', 
            administrador_id=$objeto->administrador_id, estado=$objeto->estado". 
            " Where id=$objeto->id";
			
            //Ejecutar la consulta
			$cResults = $this->enlace->executeSQL_DML( $sql);
            //--- Generos ---
            //Borrar Generos existentes asignados
            
			$sql = "Delete from material_centro_acopio Where idmaterial=$objeto->id";
			$cResults = $this->enlace->executeSQL_DML( $sql);

            //Crear elementos a insertar en generos
            foreach( $objeto->materiales as $material){
                $dataMateriales[]=array($objeto->id,$material);
            }
        
            foreach($dataMateriales as $row){
                
                $valores=implode(',', $row);
                $sql = "INSERT INTO material_centro_acopio(idmaterial,iddetalle_canje) VALUES(".$valores.");";
                $vResultado = $this->enlace->executeSQL_DML($sql);
                
            }
            
            //Retornar pelicula
            return $this->get($objeto->id);
		} catch ( Exception $e ) {
			die ( $e->getMessage () );
		}
    }    
   
}