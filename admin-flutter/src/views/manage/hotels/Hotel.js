import axios from 'axios';
import React from 'react';
import {
  CCard,
  CCardBody,
  CCardHeader,
  CCol,
  CRow,
  CTable,
  CTableBody,
  CTableCaption,
  CTableDataCell,
  CTableHead,
  CTableHeaderCell,
  CTableRow,
  CButton,
  CImage,
} from '@coreui/react';
import { DocsExample } from 'src/components';
import { useState, useEffect } from 'react';
import adminApi from 'src/api/adminApi';
import { useNavigate, useParams } from 'react-router-dom';
import { left } from '@popperjs/core';

const Hotels = () => {
  const { _id } = useParams();
  const [hotelData, setHotelData] = useState(null);

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
  return (
    <CRow>
      <CCol xs={12}>
        <CCard className="mb-4">
          <CCardHeader>
            <strong>Quản lý khách sạn</strong>
          </CCardHeader>
          <CCardBody>
            <DocsExample href="components/table#hoverable-rows">
              <CTable striped hover>
                <CTableHead>
                  <CTableRow>
                    <CTableHeaderCell scope="col">#</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Tên khách sạn</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Hình ảnh</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Địa chỉ</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Tùy chọn</CTableHeaderCell>
                  </CTableRow>
                </CTableHead>
                <CTableBody>
                  {hotelData &&
                    hotelData.map((hotel, index) => (
                      <CTableRow key={index}>
                        <CTableHeaderCell scope="row">{index + 1}</CTableHeaderCell>
                        <CTableDataCell>{hotel.name}</CTableDataCell>
                        <CTableDataCell>
                          <CImage
                            rounded
                            thumbnail
                            src={`assets/uploads/${hotel.images[0].public_id}`}
                            width={150}
                            height={100}
                            alt="Hotel Image"
                          />
                        </CTableDataCell>
                        <CTableDataCell>{hotel.desc}</CTableDataCell>
                        <CTableDataCell>
                          <CButton color="success" className="px-4" type="submit">
                            Sửa
                          </CButton>
                          <CButton
                            color="warning"
                            className="px-4"
                            type="submit"
                            href={`/manage/room/${hotel._id}`}
                          >
                            Thêm phòng
                          </CButton>
                          <CButton color="danger" className="px-4" type="submit" marginWidth={left}>
                            Xóa
                          </CButton>
                        </CTableDataCell>
                        {/* Thêm các ô dữ liệu khác nếu cần thiết */}
                      </CTableRow>
                    ))}
                </CTableBody>
              </CTable>
            </DocsExample>
          </CCardBody>
        </CCard>
      </CCol>
    </CRow>
  );
};

export default Hotels;
