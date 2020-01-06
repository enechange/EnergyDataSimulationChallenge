import React from 'react';
import { useQuery } from '@apollo/react-hooks';
import { gql } from 'apollo-boost';

import Typography from '@material-ui/core/Typography';

import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

function FormatDate(dateString) {
  const date = new Date(dateString);
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const monthTwoDigits = ('0' + month).slice(-2);

  return `${year}-${monthTwoDigits}`;
}

export default function EnergyRecords(props) {
  const houseId = props.match.params.id;

  const queryString = gql`
    {
      house(houseId: ${houseId}) {
        city
        residentsCount
        hasChildren
        houseOwner {
          lastName
        }
        householdEnergyRecords {
          id
          houseId
          recordDate
          temperature
          daylight
          energyProduction
        }
      }
    }
  `;

  const { loading, error, data } = useQuery(queryString);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :( {error}</p>;

  return (
    <>
      <Typography
        component='h1'
        variant='h2'
        align='center'
        color='textPrimary'
      >
        {data.house.houseOwner.lastName}'s House
      </Typography>
      <Typography variant='h6' align='center' color='textSecondary' paragraph>
        {data.house.residentsCount} residents{' '}
        {data.house.hasChildren ? 'with' : 'without'} children in{' '}
        {data.house.city}
      </Typography>

      <TableContainer component={Paper}>
        <Table aria-label='simple table'>
          <TableHead>
            <TableRow>
              <TableCell>Date</TableCell>
              <TableCell align='center'>Temperature</TableCell>
              <TableCell align='center'>Daylight</TableCell>
              <TableCell align='center'>Energy Production</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {data.house.householdEnergyRecords.map(
              ({ id, recordDate, temperature, daylight, energyProduction }) => (
                <TableRow key={id}>
                  <TableCell component='th' scope='row'>
                    {FormatDate(recordDate)}
                  </TableCell>
                  <TableCell align='center'>{temperature}</TableCell>
                  <TableCell align='center'>{daylight}</TableCell>
                  <TableCell align='center'>{energyProduction}</TableCell>
                </TableRow>
              )
            )}
          </TableBody>
        </Table>
      </TableContainer>
    </>
  );
}
