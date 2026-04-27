import "./styles.css";

function Pagination({
  currentPage,
  totalPages,
  paginate,
}: {
  currentPage: number;
  totalPages: number;
  paginate: (pageNumber: number) => void;
}) {
  // Tablica numerów stron wraz z warunkami wyświetlenia
  const pages = [
    { number: 1, condition: currentPage > 1 },
    { number: currentPage - 1, condition: currentPage > 2 },
    { number: currentPage + 1, condition: currentPage < totalPages - 1 },
    { number: totalPages, condition: currentPage < totalPages },
  ];

  return (
    <nav>
      <ul className="pagination">
        {pages.map(
          (page) =>
            page.condition && (
              <li key={page.number} className="page-item">
                <a
                  onClick={() => paginate(page.number)}
                  href="!#"
                  className="page-link"
                >
                  {page.number}
                </a>
              </li>
            )
        )}
      </ul>
    </nav>
  );
}

export default Pagination;
