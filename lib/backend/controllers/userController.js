import { pool } from "../server.js";

export const getUser = async (req, res) => {
    const { documento } = req.params.id;
    console.log(documento);
    console.log(req.params.id);

    try {
        const [result] = await pool.query("SELECT * FROM empleado WHERE CedulaEmpleado = ?", [req.params.id]);
        console.log(result);
        res.json(result);
    } catch (error) {
        console.error(error);
    }
};

export const loginUser = async (req, res) => {
    console.log('Petición recibida en /login');
    console.log('Cuerpo de la petición:', req.body);

    const { documento, contrasena } = req.body;

    console.log('Documento recibido:', documento);
    console.log('Contraseña recibida:', contrasena);

    try {
        const [result] = await pool.query("SELECT * FROM usuario WHERE Cedula = ? AND Contrasena = ?", [documento, contrasena]);
        console.log('Resultado de la consulta:', result);

        if (result.length === 1) {
            console.log('Inicio de sesión exitoso');
            return res.status(200).json({ messageSuccess: "Inicio de sesión exitoso", user: result[0] });
        } else {
            console.log('Credenciales inválidas');
            return res.status(401).json({ messageFail: "Credenciales inválidasss"});
        }
    } catch (error) {
        console.error("Error al iniciar sesión:", error);
        return res.status(401).json({ unknown: "Credenciales inválidasss"});

    }
};

export const getUsers = async (req, res) => {
    console.log('Petición recibida en /getUsers');
    
    try {
        const [result] = await pool.query("SELECT * FROM usuario");
        res.json(result);
    } catch (error) {
        return res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};


export const registerUser = async (req, res) => {
    console.log('Petición recibida en /registerUser');
    console.log('Información recibida:', req.body);
    const { Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE } = req.body;
    try {
        const result = await pool.query(
            "INSERT INTO usuario(Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, IDCargo, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, 4, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE]
        );
        console.log(result);
        /*res.json({
            id: result.insertId,
            nombres,
            apellidos,
            documento,
            correo,
            contraseña
        });*/
    } catch (error) {
        console.error("Error al crear usuario:", error);
        res.status(500).json({ message: error.message });
    }
};

// export const registerUser = async (req, res) => {
//     console.log('Petición recibida en /registerUser');
//     console.log('Información recibida:', req.body);
//     const { Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE } = req.body;
//     try {
//         const result = await pool.query(
//             "INSERT INTO usuario(Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, IDCargo, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
//             [Cedula, Contrasena, PrimNombre, SegNombre, PrimApellido, SegApellido, IDSexo, 4, Direccion, IDMunicipio, IDDepto, TelCel, CorreoE]
//         );
//         console.log(result);
//         /*res.json({
//             id: result.insertId,
//             nombres,
//             apellidos,
//             documento,
//             correo,
//             contraseña
//         });*/
//     } catch (error) {
//         console.error("Error al crear usuario:", error);
//         res.status(500).json({ message: error.message });
//     }
// };
export const updateUser = async (req, res) => {
    try {
        const result = await pool.query(
            "UPDATE CUENTAS_ESTU SET ? WHERE id = ?",
            [req.body, req.params.id]
        );

        res.json({ message: "Usuario actualizado correctamente" });
    } catch (error) {
        console.error("Error al actualizar usuario:", error);
        res.status(500).json({ message: error.message });
    }
};

