import axios from 'axios';
const URL = process.env.REACT_APP_SERVER_IP;

const BASE_URL = `${URL}/api`;

const createHotel = async (_id, formData) => {
  try {
    const token = localStorage.getItem('token');
    const response = await axios.post(`${BASE_URL}/hotel/create-hotel/${_id}`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
        Authorization: `Bearer ${token}`,
      },
    });

    if (!response) {
      throw new Error('Invalid response from server');
    }

    console.log(response); // Log response để kiểm tra
    return response.data;
  } catch (error) {
    throw new Error(error.response ? error.response.data.message : 'Unknown error');
  }
};

const getRoomBySlug = async (slugRoom) => {
  try {
    const response = await axios.get(`${BASE_URL}/room/${slugRoom}`);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const getRoomById = async (_id) => {
  try {
    const response = await axios.get(`${BASE_URL}/room/find/${_id}`);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const updateRoom = async (_id, formData) => {
  try {
    const response = await axios.put(`${BASE_URL}/room/update/${_id}`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const updateRoomQuantity = async (_id, quantityRoom) => {
  try {
    const response = await axios.put(`${BASE_URL}/room/update-quantity/${_id}`, { quantityRoom });
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const getRoomList = async () => {
  try {
    const response = await axios.get(`${BASE_URL}/room`);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const deleteRoom = async (_id) => {
  try {
    const response = await axios.delete(`${BASE_URL}/room/delete/${_id}`);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const hotelApi = {
  createHotel,
  getRoomList,
  updateRoom,
  getRoomBySlug,
  getRoomById,
  deleteRoom,
  updateRoomQuantity,
};

export default hotelApi;
