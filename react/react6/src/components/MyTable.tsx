import { Box, IconButton, Paper, Table, TableBody, TableCell, TableContainer, TableHead, 
    TablePagination, TableRow, TableSortLabel } from "@mui/material"
import exampleData, { IData } from "../data/ExampleData"
import useStyles from "../styles"
import { Delete } from "@material-ui/icons";
import { useState } from "react";
import ProductAddDialog from "./AddNewProduct";

type IDataKeys = keyof IData;

export const MyTable = () => {
    const classes = useStyles();
    const currency = "PLN";
    const iDataKeys: IDataKeys[] = ["id", "name", "type", "cost", "isAvailable", "amountAvailable"];

    const [rows, setRows] = useState(exampleData);
    const [page, setPage] = useState(0);
    const [rowsPerPage, setRowsPerPage] = useState(10);
    const [orderDirection, setOrderDirection] = useState<'asc' | 'desc'>('asc');
    const [orderBy, setOrderBy] = useState<keyof IData | 'id'>('id');

    const header = {fontWeight: "bold", color: "white", backgroundColor: "gray" };
    const cell = { backgroundColor: "lightgray" };

    const comparator = (a: IData, b: IData) => {
        const isAsc = orderDirection === 'asc';
        if (orderBy === 'id') {
            // Sortowanie według ID (w tym przypadku index w tablicy)
            return isAsc ? a.id - b.id : b.id - a.id;
        } else {
            if (a[orderBy] < b[orderBy]) {
                return isAsc ? -1 : 1;
            }
            if (a[orderBy] > b[orderBy]) {
                return isAsc ? 1 : -1;
            }
        }
        return 0;
    }

    const handleRequestSort = (property: keyof IData | 'id') => {
        const isAsc = orderBy === property && orderDirection === 'asc';
        setOrderDirection(isAsc ? 'desc' : 'asc');
        setOrderBy(property);
    };

    const handleDelete = (id: number) => {
        const confirmDelete = confirm(`Czy na pewno chcesz usunąć ten produkt?`);
        if (!confirmDelete) return;
        const newRows = rows.filter((_: IData, index: number) => index !== id);
        setRows(newRows);
    };

    const handlechangepage = (_: any, newpage: number) => {
        setPage(newpage)
    }
    const handleRowsPerPage = (event: { target: { value: string | number; }; }) => {
        setRowsPerPage(+event.target.value)
        setPage(0);
    }

    return (
        <Box>
        <TableContainer component={Paper} className={classes.tableContainer}>
            <Table>
                <TableHead>
                    <TableRow>
                        {
                            iDataKeys.map((key: IDataKeys) => key != 'id' && 
                                <TableCell sx={header}>
                                    <TableSortLabel
                                        active={orderBy === key}
                                        direction={orderBy === key ? orderDirection : 'asc'}
                                        onClick={() => handleRequestSort(key)}
                                    >
                                        {key}
                                    </TableSortLabel>
                                </TableCell>
                            )
                        }
                        <TableCell sx={header}> Delete </TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {rows && rows
                        .sort(comparator)
                        .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                        .map((row: IData, index) => 
                            <TableRow key={index}>
                                <TableCell style={cell}> {row.name} </TableCell>
                                <TableCell style={cell}> {row.type} </TableCell>
                                <TableCell style={cell}> {row.cost} {currency} </TableCell>
                                <TableCell style={cell}> {row.isAvailable ? "Tak" : "Nie"} </TableCell>
                                <TableCell style={cell}> {row.amountAvailable} </TableCell>
                                <TableCell style={cell}>
                                    <IconButton onClick={() => handleDelete(index)}>
                                        <Delete style={{color: 'red'}}/>
                                    </IconButton>
                                </TableCell>
                            </TableRow>
                    )}
                </TableBody>
                <TablePagination
                    rowsPerPageOptions={[5, 10, 25]}
                    rowsPerPage={rowsPerPage}
                    page={page}
                    count={rows.length}
                    showFirstButton={true}
                    showLastButton={true}
                    component="div"
                    onPageChange={handlechangepage}
                    onRowsPerPageChange={handleRowsPerPage}
                />
            </Table>
        </TableContainer>
        <ProductAddDialog
        addProduct={(newProduct) => {
            setRows([...rows, newProduct]); //.concat(newProduct));
        }}
        />
        </Box>
    )
}