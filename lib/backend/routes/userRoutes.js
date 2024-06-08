import {Router} from 'express';
import {
    getUsers,
    getUser,
    registerUser,
    updateUser,
    loginUser
} from '../controllers/userController.js';

const router = Router ();

router.get('/usuario/:id', getUser);
router.get('/getUsers', getUsers);
router.post('/registerUser', registerUser);
router.put('/user/:id', updateUser);
router.post('/login', loginUser);

export default router;