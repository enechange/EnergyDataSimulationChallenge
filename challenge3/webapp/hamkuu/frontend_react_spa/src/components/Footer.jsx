import React from 'react';
import Typography from '@material-ui/core/Typography';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  footer: {
    backgroundColor: theme.palette.divider,
    padding: theme.spacing(2),
  },
}));

const copyRightSign = () => String.fromCharCode(169);
const currentYear = () => new Date().getFullYear();
const copyRightOwner = 'Howard Shaw';

const copyRightNotice = () =>
  `Copyright ${copyRightSign()} ${currentYear()} ${copyRightOwner}. All Rights Reserved.`;

export default function Footer() {
  const classes = useStyles();

  return (
    <footer className={classes.footer}>
      <Typography variant='subtitle2' align='center' color='textSecondary'>
        {copyRightNotice()}
      </Typography>
    </footer>
  );
}
