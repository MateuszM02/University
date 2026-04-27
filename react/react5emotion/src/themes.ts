export interface ITheme {
  background: string;
  color: string;
  navbarLinkColor: string;
  themeButtonBackground: string;
  themeButtonColor: string;
  themeButtonHoverBackground: string;
  contentCardBackground: string;
  teamMemberBackground: string;
  teamMemberColor: string;
  blogPostBackground: string;
  blogPostColor: string;
  blogPostButtonBackground: string;
  blogPostButtonColor: string;
  blogPostButtonHoverBackground: string;
  evenSectionBackground: string;
  navbarBackground: string;
  contactFormBackground: string;
  contactFormColor: string;
  contactFormBorder: string;
  contactInputBackground: string;
  contactInputColor: string;
  contactInputBorder: string;
  contactButtonBackground: string;
  contactButtonColor: string;
  contactButtonHoverBackground: string;
}

export const lightTheme: ITheme = {
  background: "#fff",
  color: "#333",
  navbarLinkColor: "#333",
  themeButtonBackground: "#333",
  themeButtonColor: "#fff",
  themeButtonHoverBackground: "#555",
  contentCardBackground: "#eee",
  teamMemberBackground: "#f5f5f5",
  teamMemberColor: "#333",
  blogPostBackground: "#f0f0f0",
  blogPostColor: "#333",
  blogPostButtonBackground: "#4caf50",
  blogPostButtonColor: "#fff",
  blogPostButtonHoverBackground: "#45a049",
  evenSectionBackground: "#f5f5f5",
  navbarBackground: "#f0f0f0",
  contactFormBackground: "#f9f9f9",
  contactFormColor: "#333",
  contactFormBorder: "#ddd",
  contactInputBackground: "#fff",
  contactInputColor: "#333",
  contactInputBorder: "#ccc",
  contactButtonBackground: "#4caf50",
  contactButtonColor: "#fff",
  contactButtonHoverBackground: "#45a049",
};

export const darkTheme: ITheme = {
  background: "#111",
  color: "#fff",
  navbarLinkColor: "#fff",
  themeButtonBackground: "#ddd",
  themeButtonColor: "#333",
  themeButtonHoverBackground: "#ccc",
  contentCardBackground: "#333",
  teamMemberBackground: "#444",
  teamMemberColor: "#fff",
  blogPostBackground: "#222",
  blogPostColor: "#fff",
  blogPostButtonBackground: "#4caf50",
  blogPostButtonColor: "#fff",
  blogPostButtonHoverBackground: "#45a049",
  evenSectionBackground: "#444",
  navbarBackground: "#222",
  contactFormBackground: "#333",
  contactFormColor: "#fff",
  contactFormBorder: "#555",
  contactInputBackground: "#444",
  contactInputColor: "#fff",
  contactInputBorder: "#666",
  contactButtonBackground: "#4caf50",
  contactButtonColor: "#fff",
  contactButtonHoverBackground: "#45a049",
};
