//
//  ViewController.swift
//  FlickrGenerics
//
//  Created by Parthasarathy Gudivada on 9/23/14.
//  Copyright (c) 2014 Eagle River Solutions. All rights reserved.
//

import UIKit

class SearchResultViewController:   UIViewController,
                                    UITableViewDataSource,
                                    UITableViewDelegate,
                                    UISearchBarDelegate
{
    var tableView : UITableView?
    var searchBar : UISearchBar?
    let cellIdentifier = "cellIdentifer"
    var searches = OrderedDictionary<String, [Flickr.Photo]>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView!)
        searchBar = UISearchBar(frame: CGRectZero)
        searchBar!.setTranslatesAutoresizingMaskIntoConstraints(false)
        searchBar!.delegate = self
        view.addSubview(searchBar!)
        let viewsDictionary = [ "tableView" : tableView!,
                                "searchBar" : searchBar!]
        let table_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[searchBar]-[tableView]-|",
            options:NSLayoutFormatOptions.allZeros,
            metrics: nil,
            views: viewsDictionary)
        let table_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableView]-|",
            options:NSLayoutFormatOptions.allZeros, metrics: nil, views: viewsDictionary)
        let search_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[searchBar]-|", options:NSLayoutFormatOptions.allZeros , metrics: nil, views: viewsDictionary)
        view.addConstraints(table_constraint_H)
        view.addConstraints(search_constraint_H)
        view.addConstraints(table_constraint_V)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let(term, photos) =  self.searches[indexPath.row]
        cell.textLabel!.text = "\(term)  (\(photos.count))"
        return cell ;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searches.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let flowLayout =  UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        let (_, photos) = self.searches[indexPath.row]
        
        let searchResultController = PhotosDisplayViewController(collectionViewLayout: flowLayout)
        searchResultController.photos = photos
        self.navigationController!.pushViewController(searchResultController, animated: true)
        
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        self.searchBar!.resignFirstResponder()
        let searchTerm = searchBar.text
  
        Flickr.search( searchTerm, completion: { (result) -> Void in
                        switch (result)
                        {
                        case .Error :
                            println("Error")
                            
                            let alertController = UIAlertController(title: "Flickr Photo", message: "Error in Retrieving Pictures", preferredStyle: UIAlertControllerStyle.Alert)
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                        case .Results (let results) :
                            self.searches.insert(results,
                                forKey: searchTerm,
                                atIndex: 0)
                            
                            self.tableView!.reloadData()
                        }
            
                        })
    
        
    }
    
    

}





















