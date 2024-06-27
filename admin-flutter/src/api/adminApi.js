import axios from 'axios';

const URL = process.env.REACT_APP_SERVER_IP;

const API_URL = `${URL}/api/admin`;

const getAdminList = async () => {
  try {
    const response = await axios.get(`${API_URL}/`);
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const updateRoleAdmin = async (_id, role) => {
  try {
    const response = await axios.put(`${API_URL}/update-role-admin/${_id}`, { role });
    return response.data;
  } catch (error) {
    throw new Error(error.response.data.message);
  }
};

const register = (email, password) => {
  return axios.post(API_URL + '/register', { email, password });
};

const loginAdmin = (email, password) => {
  return axios.post(API_URL + '/login-admin', { email, password }).then((response) => {
    if (response.data.token) {
      localStorage.setItem('admin', JSON.stringify(response.data.admin));
      localStorage.setItem('token', response.data.token);
      localStorage.setItem('role', response.data.admin.role);
    }
    return response.data;
  });
};

const getAdminById = async (adminId) => {
  try {
    const response = await axios.get(`${API_URL}/select-admin/${adminId}`);

    if (!response) {
      console.error('Invalid response from server');
    }

    return response.data; // Assuming you want to return the data
  } catch (error) {
    console.error('Error fetching admin data:', error);
    throw new Error(error.response?.data?.message || 'Unknown error');
  }
};

const logout = () => {
  localStorage.removeItem('user');
  localStorage.removeItem('token');
  localStorage.removeItem('role');
};

const adminApi = {
  getAdminList,
  getAdminById,
  updateRoleAdmin,
  register,
  loginAdmin,
  logout,
};

export default adminApi;
