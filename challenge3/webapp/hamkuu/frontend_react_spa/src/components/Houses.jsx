import React from 'react';
import { NavLink } from 'react-router-dom';
import { useQuery } from '@apollo/react-hooks';
import { gql } from 'apollo-boost';

import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

const queryString = gql`
  {
    houses {
      id
      city
      houseOwner {
        firstName
        lastName
      }
      residentsCount
      hasChildren
    }
  }
`;

export default function HousesList() {
  const { loading, error, data } = useQuery(queryString);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <TableContainer component={Paper}>
      <Table aria-label='simple table'>
        <TableHead>
          <TableRow>
            <TableCell>House ID</TableCell>
            <TableCell align='center'>City</TableCell>
            <TableCell align='center'>Owner</TableCell>
            <TableCell align='center'>Residents</TableCell>
            <TableCell align='center'>Has Children</TableCell>
            <TableCell align='center'>Energy Data</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {data.houses.map(
            ({ id, city, houseOwner, residentsCount, hasChildren }) => (
              <TableRow key={id}>
                <TableCell component='th' scope='row'>
                  {id}
                </TableCell>
                <TableCell align='center'>{city}</TableCell>
                <TableCell align='center'>
                  {houseOwner.firstName} {houseOwner.lastName}
                </TableCell>
                <TableCell align='center'>{residentsCount}</TableCell>
                <TableCell align='center'>
                  {hasChildren ? 'Yes' : 'No'}
                </TableCell>
                <TableCell align='center'>
                  <NavLink to={`/energy-records/${id}`}>Details</NavLink>
                </TableCell>
              </TableRow>
            )
          )}
        </TableBody>
      </Table>
    </TableContainer>
  );
}
