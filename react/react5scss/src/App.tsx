import React, { useState } from 'react';

import AppStyles from "./styles/App.module.scss";

import BlogPostStyles from "./styles/BlogPosts.module.scss";
import ContactFormStyle from "./styles/ContactForm.module.scss";
import DarkThemeStyle from "./styles/DarkTheme.module.scss";
import LightThemeStyle from "./styles/LightTheme.module.scss";
//import HeaderStyles from "./styles/Header.module.scss";
//import FooterStyles from "./styles/Footer.module.scss";
import NavbarStyles from "./styles/Navbar.module.scss";
//import SectionStyles from "./styles/Section.module.scss";
import TeamMemberStyles from "./styles/TeamMembers.module.scss";
//import ColorStyles from "./styles/colors.module.scss";

import Footer from './components/Footer';
import Header from './components/Header';
import Navbar from './components/Navbar';
import Section from './components/Section';
import ContactForm from './components/ContactForm';
import Services from './components/Services';
import TeamMembers from './components/TeamMembers';
import BlogPosts from './components/BlogPosts';

const companyData = {
  name: "Acme Corporation",
  slogan: "Innovation at its best",
  about:
    "We are a leading provider of innovative solutions in various industries. Our team is dedicated to delivering high-quality products and services to our clients worldwide.",
  services: [
    {
      id: 1,
      name: "Web Development",
      description: "Creating modern and responsive websites.",
    },
    {
      id: 2,
      name: "Mobile App Development",
      description: "Building mobile applications for iOS and Android.",
    },
    {
      id: 3,
      name: "UI/UX Design",
      description:
        "Designing intuitive user interfaces for optimal user experience.",
    },
    {
      id: 4,
      name: "Digital Marketing",
      description:
        "Promoting products and services through various online channels.",
    },
  ],
  teamMembers: [
    {
      id: 1,
      name: "Alice Young",
      position: "CEO",
      bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero et nisi cursus, sit amet laoreet odio rutrum.",
      image: "https://via.placeholder.com/150",
    },
    {
      id: 2,
      name: "Jane Smith",
      position: "CTO",
      bio: "Duis aliquam purus ac ante volutpat, nec lobortis tortor sagittis. Sed finibus eleifend efficitur.",
      image: "https://via.placeholder.com/150",
    },
    {
      id: 3,
      name: "Alice Johnson",
      position: "Lead Designer",
      bio: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris consectetur, velit et efficitur fringilla, ligula felis dignissim.",
      image: "https://via.placeholder.com/150",
    },
  ],
  blogPosts: [
    {
      id: 1,
      title: "The Future of Technology",
      date: "March 10, 2024",
      content:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero et nisi cursus, sit amet laoreet odio rutrum.",
    },
    {
      id: 2,
      title: "Design Trends for 2024",
      date: "February 28, 2024",
      content:
        "Duis aliquam purus ac ante volutpat, nec lobortis tortor sagittis. Sed finibus eleifend efficitur.",
    },
    {
      id: 3,
      title: "The Power of Social Media",
      date: "February 15, 2024",
      content:
        "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris consectetur, velit et efficitur fringilla, ligula felis dignissim.",
    },
    {
      id: 4,
      title: "Artificial Intelligence in Business",
      date: "January 30, 2024",
      content:
        "Suspendisse eget sapien vitae eros tincidunt ultrices. Morbi nec sem nisi. Nulla ultrices odio et eros varius, a eleifend velit tristique.",
    },
    {
      id: 5,
      title: "The Impact of Virtual Reality",
      date: "January 15, 2024",
      content:
        "Integer auctor neque mauris, eget sagittis justo tristique sit amet. Nam at nibh et nulla suscipit blandit eu nec mi.",
    },
  ],
};

const App = () => {
  const [darkMode, setDarkMode] = useState(false);

  const toggleTheme = () => {
    setDarkMode(!darkMode);
  };

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
  };

  return (
    <div className={`${AppStyles.portfolio} ${darkMode ? DarkThemeStyle.darkTheme : LightThemeStyle.lightTheme}`}>
      <Navbar toggleTheme={toggleTheme} darkMode={darkMode} />
      <Header name={companyData.name} slogan={companyData.slogan} />
      <div className={AppStyles.contentCard}>
        <Section id={NavbarStyles.about} className={NavbarStyles.about} title="About Us">
          <p>{companyData.about}</p>
        </Section>
        <Section id={AppStyles.services} className={AppStyles.services} title="Our Services">
          <Services services={companyData.services}/>
        </Section>
        <Section id={TeamMemberStyles.team} className={TeamMemberStyles.team} title="Meet Our Team">
          <TeamMembers teamMembers={companyData.teamMembers} />
        </Section>
        <Section id={BlogPostStyles.blog} className={BlogPostStyles.blog} title="Latest Blog Posts">
          <BlogPosts blogPosts={companyData.blogPosts}/>
        </Section>
        <Section id={ContactFormStyle.contact} className={ContactFormStyle.contact} title="Contact Us">
          <ContactForm handleSubmit={handleSubmit} />
        </Section>
      </div>
      <Footer companyName={companyData.name} />
    </div>
  );
};

export default App;