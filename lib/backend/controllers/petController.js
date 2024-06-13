import { pool } from "../server.js";

export const getPet = async (req, res) => {
  const { documento } = req.params.documento;

  try {
    const [result] = await pool.query(
      "SELECT * FROM mascota WHERE Cedula = ?",
      [req.params.id]
    );
    if (result.length === 1) {
      return res
        .status(200)
        .json({ messageSuccess: "Usuario encontrado", user: result[0] });
    }
  } catch (error) {
    return res.status(401).json({ unknown: "Error con la consulta" });
  }
};

export const getPets = async (req, res) => {
  console.log("Petición recibida en /getPets");

  try {
    const [result] = await pool.query("SELECT * FROM mascota");
    res.json(result);
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
    console.log("Registro exitoso");
    return res.status(200).json({ messageSuccess: "Registro exitoso" });
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
