import {Router} from 'express';
import {
    getPet,
    getPets,
    registerPet,
    updatePet,
} from '../controllers/petController.js';

const router = Router ();

router.get('/pet/:id', getPet);
router.get('/getPets', getPets);
router.post('/registerPet', registerPet);
router.put('/pet/:id', updatePet);

export default router;