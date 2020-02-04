import React from 'react';
import { Route } from 'react-router-dom';

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';

import TabButton from './TabButton';

function HomeButton() {
  return (
    <TabButton buttonText='Household Energy Dashboard' url='/'></TabButton>
  );
}

function BackButton() {
  return <TabButton buttonText='Go Back' url='/'></TabButton>;
}

export default function Header() {
  return (
    <>
      <AppBar position='static' color='default'>
        <Toolbar variant='dense'>
          <Route exact path='/' component={HomeButton} />
          <Route path='/energy-records' component={BackButton} />
        </Toolbar>
      </AppBar>
    </>
  );
}
