import React, { Suspense } from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import './App.css';

import { ApolloProvider } from '@apollo/react-hooks';
import ApolloClient from 'apollo-boost';

import Header from './components/Header';
import Footer from './components/Footer';
import Houses from './components/Houses';
import EnergyRecords from './components/EnergyRecords';

const client = new ApolloClient({
  uri: `${process.env.REACT_APP_API_URL_BASE}/graphql`,
});

function AppLayout() {
  return (
    <>
      <Route path='/' component={Header} />

      <main>
        <ApolloProvider client={client}>
          <Route exact path='/' component={Houses} />
          <Route exact path='/energy-records/:id' component={EnergyRecords} />
        </ApolloProvider>
      </main>

      <Route path='/' component={Footer} />
    </>
  );
}

function App() {
  return (
    <BrowserRouter>
      <Switch>
        <Suspense fallback={<div>Loading...</div>}>
          <AppLayout />
        </Suspense>
      </Switch>
    </BrowserRouter>
  );
}

export default App;
