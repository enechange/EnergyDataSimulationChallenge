import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import Tab from '@material-ui/core/Tab';

const useStyles = makeStyles(() => ({
  tabButton: {
    textTransform: 'none',
    '&:hover': {
      color: '#A9A9A9',
      opacity: 1,
    },
  },
}));

export default function TabButton(props) {
  const classes = useStyles();
  const { url, buttonText } = props;

  return <Tab label={buttonText} className={classes.tabButton} href={url} />;
}

TabButton.propTypes = {
  buttonText: PropTypes.string,
  url: PropTypes.string,
};

TabButton.defaultProps = {
  buttonText: 'UNDEFINED',
  url: '/',
};
