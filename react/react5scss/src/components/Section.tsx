import React from 'react';
import classes from "../styles/Section.module.scss";

type SectionProps = {
  id: string;
  className: string;
  title: string;
  children: React.ReactNode;
};

const Section: React.FC<SectionProps> = ({ id, className, title, children }) => {
  return (
    <section id={id} className={`${classes.section} ${className}`}>
      <div className={`${classes.section}Content`}>
        <h2>{title}</h2>
        {children}
      </div>
    </section>
  );
};

export default Section;