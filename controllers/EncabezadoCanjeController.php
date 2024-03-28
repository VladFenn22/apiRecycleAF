<?php

class encabezadocanje
{
    //GET Listar 
    public function index()
    {
        //Instancia del modelo
        $EncabezadoCanje = new EncabezadoCanjeModel();
        //Acción del modelo a ejecutar
        $response = $EncabezadoCanje->all();
        if (isset($response) && !empty($response)) {
            $json = array(
                'status' => 200,
                'results' => $response
            );
        } else {
            $json = array(
                'status' => 400,
                'results' => "No hay registros"
            );
        }
        //Escribir respuesta JSON con código de estado HTTP
        echo json_encode(
            $json,
            http_response_code($json["status"])
        );
    }
    //GET Obtener 
    public function get($id)
    {
        //Instancia del modelo
        $EncabezadoCanje = new EncabezadoCanjeModel();
        //Acción del modelo a ejecutar
        $response = $EncabezadoCanje->get($id);
        //Verificar respuesta
        if (isset($response) && !empty($response)) {
            //Armar el JSON respuesta satisfactoria
            $json = array(
                'status' => 200,
                'results' => $response
            );
        } else {
            //JSON respuesta negativa
            $json = array(
                'status' => 400,
                'results' => "No existe el recurso solicitado"
            );
        }
        //Escribir respuesta JSON con código de estado HTTP
        echo json_encode(
            $json,
            http_response_code($json["status"])
        );
    }
    //GET Obtener con formato para formulario
    public function getForm($id){   
        //Instancia del modelo     
        $EncabezadoCanje=new EncabezadoCanjeModel();
        $json=array(
            'status'=>400,
            'results'=>"Solicitud sin identificador"
        );
        //Verificar párametro
        if(isset($id) && !empty($id) && $id!=='undefined' && $id!=='null'){
            //Acción del modelo a ejecutar
            $response=$EncabezadoCanje->getForm($id);
            //Verificar respuesta
            if(isset($response) && !empty($response)){
                //Armar el json
                $json=array(
                    'status'=>200,
                    'results'=>$response
                );
            }else{
                $json=array(
                    'status'=>400,
                    'results'=>"No existe el recurso solicitado"
                );
            }
           
        }
        //Escribir respuesta JSON con código de estado HTTP
        echo json_encode($json,
            http_response_code($json["status"])
        ); 
    }
  
    //POST Crear
    public function create()
    {
        //Obtener json enviado
        $inputJSON = file_get_contents('php://input');
        //Decodificar json
        $object = json_decode($inputJSON);
        //Instancia del modelo
        $EncabezadoCanje = new EncabezadoCanjeModel();
        //Acción del modelo a ejecutar
        $response = $EncabezadoCanje->create($object);
        //Verificar respuesta
        if (isset($response) && !empty($response)) {
            $json = array(
                'status' => 200,
                'results' => $response
            );
        } else {
            $json = array(
                'status' => 400,
                'results' => "No se creo el recurso"
            );
        }
        //Escribir respuesta JSON con código de estado HTTP
        echo json_encode(
            $json,
            http_response_code($json["status"])
        );

    }
    //PUT actualizar
    public function update()
    {
        //Obtener json enviado
        $inputJSON = file_get_contents('php://input');
        //Decodificar json
        $object = json_decode($inputJSON);
        //Instancia del modelo
        $EncabezadoCanje = new EncabezadoCanjeModel();
        //Acción del modelo a ejecutar
        $response = $EncabezadoCanje->update($object);
        //Verificar respuesta
        if (isset($response) && !empty($response)) {
            $json = array(
                'status' => 200,
                'results' => "Pelicula actualizada"
            );
        } else {
            $json = array(
                'status' => 400,
                'results' => "No se actualizo el recurso"
            );
        }
        //Escribir respuesta JSON con código de estado HTTP
        echo json_encode(
            $json,
            http_response_code($json["status"])
        );
    }
}