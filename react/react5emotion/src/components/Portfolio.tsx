/** @jsxImportSource @emotion/react */
import { CSSObject, useTheme } from "@emotion/react";
import { ITheme } from "../themes";

import React from "react";
import Navbar from "./Navbar";
import Header from "./Header";
import Section from "./Section";
import ServiceListItem from "./ServiceListItem";
import MemberListItem from "./MemberListItem";
import BlogPostListItem from "./BlogPostListItem";
import ContactForm from "./ContactForm";
import Footer from "./Footer";

interface IProps {
  companyData: {
    name: string;
    slogan: string;
    about: string;
    services: {
      id: number;
      name: string;
      description: string;
    }[];
    teamMembers: {
      id: number;
      name: string;
      position: string;
      bio: string;
      image: string;
    }[];
    blogPosts: {
      id: number;
      title: string;
      date: string;
      content: string;
    }[];
  };
  toggleTheme: () => void;
  darkMode: boolean;
}

const servicesCss: CSSObject = {
  ul: {
    listStyle: "none",
    padding: "0",
    margin: "0",
  },

  li: {
    marginBottom: "20px",
    textAlign: "left",
  },

  h3: {
    fontSize: "1.8em",
    marginBottom: "10px",
  },
};

const teamCss: CSSObject = {
  display: "flex",
  flexWrap: "wrap",
  justifyContent: "center",
};

const blogCss: CSSObject = {
  display: "grid",
  gridTemplateColumns: "repeat(auto-fit, minmax(300px, 1fr))",
  gridGap: "20px",
};

const contactCss: (theme: ITheme) => CSSObject = (theme) => {
  return {
    marginBottom: "40px",

    ".form-group": {
      marginBottom: "20px",
    },

    'input[type="text"], input[type="email"], textarea': {
      width: "calc(100% - 20px)",
      padding: "10px",
      borderRadius: "5px",
      marginTop: "5px",
      backgroundColor: theme.contactInputBackground,
      color: theme.contactInputColor,
      border: `1px solid ${theme.contactInputBorder}`,
    },

    textarea: {
      resize: "vertical",
    },

    button: {
      padding: "10px 20px",
      border: "none",
      borderRadius: "5px",
      cursor: "pointer",
      transition: "background-color 0.3s ease",
      backgroundColor: theme.contactButtonBackground,
      color: theme.contactButtonColor,

      "&:hover": {
        backgroundColor: theme.contactButtonHoverBackground,
      },
    },
  };
};

export default function Portfolio({
  companyData,
  toggleTheme,
  darkMode,
}: IProps) {
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
  };

  const theme = useTheme() as ITheme;

  return (
    <div
      css={{
        margin: "0 auto",
        backgroundColor: theme.background,
        color: theme.color
      }}
    >
      <Navbar
        links={{
          header: "Home",
          about: "About",
          services: "Services",
          team: "Team",
          blog: "Blog",
          contact: "Contact",
        }}
        toggleTheme={toggleTheme}
        darkMode={darkMode}
      />
      <Header name={companyData.name} slogan={companyData.slogan} />
      <div
        css={{
          borderRadius: "10px",
          margin: "20px 0",
          backgroundColor: theme.contentCardBackground,
        }}
      >
        <Section id="about" h2="About Us">
          <p>{companyData.about}</p>
        </Section>
        <Section id="services" h2="Our Services" css={servicesCss}>
          <ul>
            {companyData.services.map((service) => (
              <ServiceListItem service={service} />
            ))}
          </ul>
        </Section>
        <Section id="team" h2="Meet Our Team">
          <div css={teamCss}>
            {companyData.teamMembers.map((member) => (
              <MemberListItem member={member} />
            ))}
          </div>
        </Section>
        <Section id="blog" h2="Latest Blog Posts">
          <div css={blogCss}>
            {companyData.blogPosts.map((post) => (
              <BlogPostListItem post={post} />
            ))}
          </div>
        </Section>
        <Section id="contact" h2="Contact Us" css={contactCss(theme)}>
          <ContactForm handleSubmit={handleSubmit} />
        </Section>
      </div>
      <Footer name={companyData.name} />
    </div>
  );
}
