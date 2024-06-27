import React from 'react';
import {
  CButton,
  CCard,
  CCardBody,
  CCardHeader,
  CCol,
  CForm,
  CFormInput,
  CFormLabel,
  CFormSelect,
  CFormTextarea,
  CFormCheck,
  CRow,
} from '@coreui/react';
import { DocsExample } from 'src/components';
import { useState, useEffect } from 'react';
import hotelApi from 'src/api/hotelApi';
import { ToastContainer, toast } from 'react-toastify';
import { useNavigate, useParams } from 'react-router-dom';
import adminApi from 'src/api/adminApi';

const amenities = [
  { id: 1, name: 'Fiwi' },
  { id: 2, name: 'Dining' },
  { id: 3, name: 'Swimming Pool' },
  { id: 4, name: 'Shoping' },
  { id: 5, name: 'Car rentalCar rental' },
  { id: 6, name: 'Bathroom' },
  { id: 7, name: 'Customer Care' },
  { id: 8, name: 'Luggage storage' },
  { id: 9, name: 'Room service' },
  { id: 10, name: 'Restaurants' },
];

const CreateRoom = () => {
  const [hotelData, setHotelData] = useState(null);
  const { _id } = useParams();
  const navigate = useNavigate();
  const [formValues, setFormValues] = useState({
    name: '',
    address: '',
    desc: '',
    nearby: 0,
    contact: '',
    amenities: [],
    images: null,
  });

  useEffect(() => {
    const fetchHotelData = async () => {
      try {
        const adminInfo = await adminApi.getAdminById(_id);
        setHotelData(adminInfo.hotel);
      } catch (error) {
        console.error('Error fetching hotel data', error);
      }
    };

    fetchHotelData();
  }, [_id]);
  console.log(hotelData);
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormValues((prevValues) => ({
      ...prevValues,
      [name]: value,
    }));
  };
  const handleAmenitiesChange = (e) => {
    const { value, checked } = e.target;
    setFormValues((prevValues) => {
      let amenities = [...prevValues.amenities];
      if (checked) {
        amenities.push(value);
      } else {
        amenities = amenities.filter((item) => item !== value);
      }
      return {
        ...prevValues,
        amenities,
      };
    });
  };
  const handleImagesChange = (e) => {
    const selectedImages = e.target.files;
    setFormValues((prevValues) => ({
      ...prevValues,
      images: selectedImages,
    }));
  };
  const handleSubmit = (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append('name', formValues.name);
    formData.append('address', formValues.address);
    formData.append('desc', formValues.desc);
    formData.append('nearby', formValues.nearby);
    formData.append('contact', formValues.contact);
    formData.append('amenities', JSON.stringify(formValues.amenities));
    if (typeof formValues.images === 'object' && formValues.images !== null) {
      formData.append('images', formValues.images);
    }

    for (const image of formValues.images) {
      formData.append('images', image);
    }

    const errors = {};

    if (formValues.images === null || typeof formValues.images !== 'object') {
      errors.images = 'Vui lòng chọn ảnh cho phòng';
    }

    for (let [key, value] of formData.entries()) {
      if (value === null || value === '') {
        errors[key] = `${key} Không được để trống`;
      } else if (key === 'name' || key === 'address' || key === 'desc' || key === 'contact') {
        if (value <= 0) {
          errors[key] = 'Giá trị phải lớn hơn 0';
        }
      } else if (key === 'amenities') {
        if (value.length === 0) {
          errors[key] = 'Phải chọn ít nhất 1 tiện ích';
        }
      } else if (key === 'name' || key === 'address' || key === 'desc' || key === 'contact') {
        if (/[*&^%$#@!()+={}|[\]\\]/g.test(value)) {
          errors[key] = 'Không được chứa kí tự đặc biệt';
        }
      }
    }

    if (Object.keys(errors).length > 0) {
      // Hiển thị toast cho từng lỗi
      for (let key in errors) {
        toast.error(errors[key]);
      }
      return;
    }

    hotelApi
      .createHotel(_id, formData)
      .then((response) => {
        toast.success('Tạo khách sạn thành công');
        setTimeout(() => {
          navigate('/manage/list');
        }, 3000);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  return (
    <CRow>
      <CCol xs={12}>
        <CCard className="mb-4">
          <CCardHeader>
            <strong>Tạo phòng cho khách sạn</strong>
          </CCardHeader>
          <CCardBody>
            <DocsExample href="forms/form-control">
              <CForm encType="multipart/form-data" onSubmit={handleSubmit}>
                <div className="row">
                  <div className="col">
                    <CFormLabel htmlFor="name">Tên khách sạn</CFormLabel>
                    <CFormInput
                      type="text"
                      id="name"
                      name="name"
                      value={formValues.name}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col">
                    <CFormLabel htmlFor="address">Địa chỉ khách sạn</CFormLabel>
                    <CFormInput
                      type="text"
                      id="address"
                      name="address"
                      value={formValues.address}
                      onChange={handleChange}
                    />
                  </div>
                </div>

                <div className="row">
                  <div className="col">
                    <CFormLabel htmlFor="contact">Thông tin liên hệ</CFormLabel>
                    <CFormInput
                      type="text"
                      id="contact"
                      name="contact"
                      value={formValues.contact}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col">
                    <CFormLabel htmlFor="nearby">Cách trung tâm thành phố</CFormLabel>
                    <CFormInput
                      type="number"
                      id="nearby"
                      name="nearby"
                      value={formValues.nearby}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col">
                    <CFormLabel htmlFor="images">Chọn hình ảnh của khách sạn</CFormLabel>
                    <CFormInput
                      type="file"
                      id="images"
                      multiple
                      name="images"
                      onChange={handleImagesChange}
                    />
                  </div>
                </div>
                <div className="row">
                  <CFormLabel htmlFor="amenities">Các dịch vụ của khách sạn</CFormLabel>
                  {amenities.map((item) => {
                    return (
                      <div className="col-2" key={item.id}>
                        <input
                          type="checkbox"
                          name="amenities"
                          value={item.name}
                          onChange={handleAmenitiesChange}
                        />
                        <p> {item.name} </p>
                      </div>
                    );
                  })}
                </div>

                <div className="mb-3">
                  <CFormLabel htmlFor="desc">Giới thiệu về khách sạn</CFormLabel>
                  <CFormTextarea
                    id="desc"
                    name="desc"
                    value={formValues.desc}
                    onChange={handleChange}
                    rows={5}
                  ></CFormTextarea>
                </div>
                <CButton color="primary" className="px-4" type="submit">
                  Khởi tạo
                </CButton>
              </CForm>
            </DocsExample>
          </CCardBody>
        </CCard>
      </CCol>
    </CRow>
  );
};

export default CreateRoom;
