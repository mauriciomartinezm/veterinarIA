import { pool } from "../server.js";

export const getPet = async (req, res) => {
  console.log("Petición recibida en /getPet");
  console.log("Parámetros de la petición:", req.params);

  try {
    const [result] = await pool.query(
      "SELECT * FROM mascota WHERE IDMascota = ?",
      [req.params.IDMascota]
    );

    if (result.length === 1) {
      console.log("Mascota: ", result[0]);

      return res
        .status(200)
        .json({ messageSuccess: "Mascota encontrada", pet: result[0] });
    }
  } catch (error) {
    return res.status(401).json({ unknown: "Error con la consulta" });
  }
};

export const getPets = async (req, res) => {
  console.log("Petición recibida en /getPets");
  console.log("Parámetros recibidos: ", req.params);
  try {
    const [result] = await pool.query(
      "SELECT * FROM mascota where CedulaPropietario = ?",
      [req.params.cedulaPropietario]
    );
    res.json(result);
    console.log(result);
    return result;
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Error interno del servidor", error: error.message });
  }
};

export const registerPet = async (req, res) => {
  console.log("Petición recibida en /registerPet");
  console.log("Información recibida:", req.body);
  const { Nombre, CedulaPropietario, FIngreso } = req.body;
  try {
    // Verificar si el usuario ya existe
    const [existingPet] = await pool.query(
      "SELECT Nombre FROM mascota WHERE Nombre = ? AND CedulaPropietario = ?",
      [Nombre, CedulaPropietario]
    );

    if (existingPet.length > 0) {
      console.log("La mascota ya está registrada");
      return res
        .status(409)
        .json({ existingPet: "La mascota ya está registrada" });
    }

    const result = await pool.query(
      "INSERT INTO mascota(Nombre, CedulaPropietario, FIngreso) VALUES (?, ?, ?)",
      [Nombre, CedulaPropietario, FIngreso]
    );
    const insertedId = await pool.query("SELECT LAST_INSERT_ID()");
    var idReturned = insertedId[0][0]["LAST_INSERT_ID()"];

    console.log("Registro exitoso");
    console.log("ID de la mascota insertada:", idReturned);
    return res
      .status(200)
      .json({ messageSuccess: "Registro exitoso", id: idReturned });
  } catch (error) {
    console.error("Error al crear usuario:", error);
    return res.status(500).json({ messageFail: error.message });
  }
};

export const updatePet = async (req, res) => {
  try {
    const result = await pool.query("UPDATE CUENTAS_ESTU SET ? WHERE id = ?", [
      req.body,
      req.params.id,
    ]);

    res.json({ message: "Usuario actualizado correctamente" });
  } catch (error) {
    console.error("Error al actualizar usuario:", error);
    res.status(500).json({ message: error.message });
  }
};
export const deletePet = async (req, res) => {
  console.log("Petición recibida en /deletePet");
  console.log("Parámetros recibidos: ", req.params);
  try {
    const result = await pool.query("DELETE FROM mascota WHERE IDMascota = ?", [
      req.params.IDMascota,
    ]);

    console.log("Mascota eliminada");
    res.status(200).json({ message: "Mascota eliminada correctamente" });
  } catch (error) {
    console.error("Error al eliminar mascota:", error);
    res
      .status(500)
      .json({ message: "Error interno del servidor", error: error.message });
  }
};
